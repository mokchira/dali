#version 460

layout(location = 0) in vec2 uv;

layout(location = 0) out vec4 outColor;

layout(set = 0, binding = 0) uniform Brush {
    float x;
    float y;
    float radius;
    float r;
    float g;
    float b;
    int   mode;
} brush;

void main()
{
    vec2 brushPos = vec2(brush.x, brush.y);
    float d = distance(uv, brushPos);
    float outer = 1 - step(brush.radius, d);
    float inner = 1 - step(brush.radius - 0.002, d);
    float c = outer - inner;
    outColor = vec4(1, 1, 1, c);
}
