//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}


//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Multiply Shader
//

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D texMultiply;

void main()
{
    vec4 inColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    vec4 blend = texture2D(texMultiply, v_vTexcoord);
    vec4 outColor = vec4(blend.rgb * inColor.rgb, inColor.a);
    gl_FragColor =  mix(outColor, inColor, 1.0 - blend.a);
    vec4 col = texture2D(gm_BaseTexture, v_vTexcoord);

    vec3 lum = vec3(0.299, 0.587, 0.114);
    float gray = dot(col.xyz, lum);
    float factor = col.b; //factor to preserve gray
    gl_FragColor = vec4((gray * factor) + (col.r * (1.0-factor)), (gray * factor) + (col.g * (1.0-factor)), (gray * factor) + (col.b * (1.0-factor)), col.a*v_vColour.a);
}

