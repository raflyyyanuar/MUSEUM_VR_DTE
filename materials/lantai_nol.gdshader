shader_type canvas_item;

uniform sampler2D color_map : source_color;

void fragment(){
	// Calculate the UV coordinates for the current pixel
	vec2 uv = SCREEN_UV;

	// Sample the red channel from the color map texture
	float redValue = texture(color_map, uv).r;

	// Calculate the emission strength based on the sine wave of redValue
	float emissionStrength = 0.5 + 0.5 * sin(redValue * 2.0 * 3.141592);

	// Set the emission color to white and scale it by the emissionStrength
	// COLOR emissionColor = vec4(1.0, 1.0, 1.0, emissionStrength);

	// Set the material's emission to the calculated emission color
	
	EMISSION = COLOR;
}
