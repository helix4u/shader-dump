import os
from PIL import Image
import moderngl
import numpy as np
from typing import Literal, Optional

from invokeai.app.invocations.primitives import ImageField, ImageOutput
from invokeai.invocation_api import BaseInvocation, Input, InputField, InvocationContext, WithMetadata, WithBoard, invocation

SHADERS_PATH = os.path.join(os.path.dirname(os.path.abspath(__file__)), "shaders")

def getDirs(filename: str):
    dirs = []
    all_entries = os.listdir(SHADERS_PATH)
    for e in all_entries:
        entry_path = os.path.join(SHADERS_PATH, e)
        if os.path.isdir(entry_path):
            if filename in os.listdir(entry_path):
                dirs.append(e)
    return dirs

VERT_PATHS = Literal[tuple(getDirs('vert.glsl'))]
FRAG_PATHS = Literal[tuple(getDirs('frag.glsl'))]

@invocation(
    "glsl-render",
    title="GLSL Shader",
    tags=["glsl", "shader", "opengl"],
    category="image",
    version="1.1.1",
)
class GLSLShader(BaseInvocation, WithMetadata, WithBoard):
    """Applies a GLSL shader to an image"""

    image: ImageField = InputField(description="The image to apply shader to")
    vertex_shader: VERT_PATHS = InputField(default='default', input=Input.Direct)
    fragment_shader: FRAG_PATHS = InputField(default='default', input=Input.Direct)

    palette_texture: Optional[ImageField] = InputField(description="Palette texture", default=None)
    depth_map_texture: Optional[ImageField] = InputField(description="Depth map texture", default=None)
    normal_map_texture: Optional[ImageField] = InputField(description="Normal map texture", default=None)
    
    var1_name: str = InputField(default="var1", description="Name of the first shader variable")
    var1_value: float = InputField(default=1.0, description="Value of the first shader variable")
    
    var2_name: str = InputField(default="var2", description="Name of the second shader variable")
    var2_value: float = InputField(default=1.0, description="Value of the second shader variable")

    def invoke(self, context: InvocationContext) -> ImageOutput:
        full_vert = os.path.join(SHADERS_PATH, f"{self.vertex_shader}/vert.glsl")
        full_frag = os.path.join(SHADERS_PATH, f"{self.fragment_shader}/frag.glsl")

        ctx = moderngl.create_standalone_context()

        # Load main image
        pil_image = context.images.get_pil(self.image.image_name)
        texture_size = pil_image.size
        image_data = np.array(pil_image).astype('f4') / 255.0
        texture = ctx.texture(texture_size, 3, data=image_data.tobytes(), dtype='f4')
        texture.use(location=0)

        # Load and resize additional textures to match the main image's size
        if self.palette_texture:
            pil_palette = context.images.get_pil(self.palette_texture.image_name)
            pil_palette = pil_palette.resize(texture_size)  # Resize to match the main image
            palette_data = np.array(pil_palette).astype('f4') / 255.0
            palette_texture = ctx.texture(texture_size, 3, data=palette_data.tobytes(), dtype='f4')
            palette_texture.use(location=1)
        
        if self.depth_map_texture:
            pil_depth = context.images.get_pil(self.depth_map_texture.image_name)
            pil_depth = pil_depth.convert("L")  # Ensure depth map is grayscale
            pil_depth = pil_depth.resize(texture_size)  # Resize to match the main image
            depth_data = np.array(pil_depth).astype('f4') / 255.0
            depth_texture = ctx.texture(texture_size, 1, data=depth_data.tobytes(), dtype='f4')
            depth_texture.use(location=2)
        
        if self.normal_map_texture:
            pil_normal = context.images.get_pil(self.normal_map_texture.image_name)
            pil_normal = pil_normal.resize(texture_size)  # Resize to match the main image
            normal_data = np.array(pil_normal).astype('f4') / 255.0
            normal_texture = ctx.texture(texture_size, 3, data=normal_data.tobytes(), dtype='f4')
            normal_texture.use(location=3)

        fbo = ctx.framebuffer(color_attachments=[ctx.texture(texture_size, 3, dtype='f4')])
        fbo.use()

        program = ctx.program(
            vertex_shader=open(full_vert).read(),
            fragment_shader=open(full_frag).read(),
        )

        if "texture_size" in program:
            program["texture_size"].value = texture.size

        if self.var1_name in program:
            program[self.var1_name].value = self.var1_value
        if self.var2_name in program:
            program[self.var2_name].value = self.var2_value

        vertices = np.array([
            -1.0, 1.0, 0.0, 1.0,
            -1.0, -1.0, 0.0, 0.0,
            1.0, -1.0, 1.0, 0.0,
            -1.0, 1.0, 0.0, 1.0,
            1.0, -1.0, 1.0, 0.0,
            1.0, 1.0, 1.0, 1.0,
        ], dtype='f4')

        vbo = ctx.buffer(vertices)
        vao = ctx.simple_vertex_array(program, vbo, 'in_vert', 'in_uv')

        vao.render()

        data = fbo.read(components=3, dtype='f4')
        data = np.frombuffer(data, dtype=np.float32).reshape((*texture_size, 3))
        data = (data * 255).astype(np.uint8)

        img_out = Image.frombytes('RGB', texture_size, data)

        image_dto = context.images.save(image=img_out)

        return ImageOutput.build(image_dto)
