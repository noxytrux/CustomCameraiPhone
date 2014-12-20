uniform sampler2D SamplerY;
uniform sampler2D SamplerUV;
uniform mediump float saturationFactor;

varying highp vec2 texCoordVarying;

void main()
{
    mediump vec3 yuv;
    mediump vec3 rgb;
    
    yuv.x  = texture2D(SamplerY, texCoordVarying).r;
    yuv.yz = texture2D(SamplerUV, texCoordVarying).rg - vec2(0.5, 0.5);
    
    rgb = mat3( 1.0, 1.0, 1.0,
                0.0, -.18732, 1.8556,
                1.57481, -.46813, 0.0) * yuv;
    
    mediump vec3 gray = vec3(dot(rgb, vec3(0.2126, 0.7152, 0.0722)));
    mediump vec3 outColor = mix(rgb, gray, saturationFactor);
    
    gl_FragColor = vec4(outColor, 1.0);
}


