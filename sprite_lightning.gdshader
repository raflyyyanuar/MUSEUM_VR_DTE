shader_type canvas_item;
uniform float amplitude : hint_range(0, 1);
uniform float frequency : hint_range(0, 10);
uniform float thickness : hint_range(0, 10);
uniform float noise_scale : hint_range(0, 10);


vec2 random(vec2 uv){
    uv = vec2( dot(uv, vec2(127.1,311.7) ),
               dot(uv, vec2(269.5,183.3) ) );
    return -1.0 + 2.0 * fract(sin(uv) * 43758.5453123);
}

float noise(vec2 uv) {
    vec2 uv_index = floor(uv);
    vec2 uv_fract = fract(uv);

    vec2 blur = smoothstep(0.0, 1.0, uv_fract);

    return mix( mix( dot( random(uv_index + vec2(0.0,0.0) ), uv_fract - vec2(0.0,0.0) ),
                     dot( random(uv_index + vec2(1.0,0.0) ), uv_fract - vec2(1.0,0.0) ), blur.x),
                mix( dot( random(uv_index + vec2(0.0,1.0) ), uv_fract - vec2(0.0,1.0) ),
                     dot( random(uv_index + vec2(1.0,1.0) ), uv_fract - vec2(1.0,1.0) ), blur.x), blur.y) + 0.5;
}


void fragment() {
    // Calculate a value based on the time and coordinates.
    vec2 coord = vec2(FRAGCOORD.x, FRAGCOORD.y);
    float lightning = sin((coord.x + coord.y) * frequency * TIME);
    
    // Apply Perlin noise to the lightning
    lightning += noise(coord);
    
    // Adjust the amplitude and apply thickness.
    lightning = (lightning * amplitude) * thickness;
    
    // Modify the fragment color based on the lightning value.
    COLOR = mix(COLOR, vec4(1.0, 1.0, 1.0, 1.0), lightning);
}