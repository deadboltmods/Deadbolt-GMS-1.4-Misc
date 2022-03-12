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
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    vec4 col = texture2D( gm_BaseTexture, v_vTexcoord );
    float brightness = 0.34 * col.r + 0.5 * col.g + 0.16 * col.b;
if (brightness < 0.3) {
        col.rgb = vec3(124.0/255.0, 223.0/255.0, 228.0/255.0);
        //col.a = 1.0;
    }
    else if (brightness < 0.4) {
        col.rgb = vec3(174.0/255.0, 225.0/255.0, 225.0/255.0);
        //col.a = 0.8;
    }
    else {
        col.rgb = vec3(219.0/255.0, 251.0/255.0, 248.0/255.0);
        //col.a = 0.6;
    }

    gl_FragColor = v_vColour * col;
}

//0.33 R + 0.5 G + 0.16 B
    /*else if (brightness < 0.9) {
        col.rgb = vec3(51.0/255.0, 71.0/255.0, 75.0/255.0);
        //col.a = 0.4;
    }*/
        /*else if (brightness < 1.0) {
        col.rgb = vec3(51.0/255.0, 71.0/255.0, 75.0/255.0);
        //col.a = 0.4;
    }*/

