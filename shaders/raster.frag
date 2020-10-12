#version 460

layout(location = 0) in  vec3 inColor;
layout(location = 1) in  vec3 inNormal;
layout(location = 2) in  vec3 inUvw;

layout(location = 0) out vec4 outColor;

layout(set = 0, binding = 3) uniform sampler2D image;

const vec3 lightDir = {-0.707106769, -0.5, -0.5};

void main()
{
    float illume = clamp(dot(-1 * inNormal, lightDir), 0.0, 1.0);
    vec4 tex = texture(image, inUvw.xy).rgba;
    outColor = tex * illume;
    //outColor = vec4(inUvw, 1);
}
