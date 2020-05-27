shader_type spatial;
render_mode cull_disabled;
uniform sampler2D noise;
uniform vec4 grass_color : hint_color;
uniform float time_scale = 0.5;
uniform float side_to_side = 0.5;
uniform float mask_black = 0.5;
uniform float mask_white = 0.5;

void vertex() {
	vec3 noi = texture(noise, VERTEX.xz / 100.0).xyz;
	float time = (TIME * (0.5 + INSTANCE_CUSTOM.y) * time_scale) + (6.0 * noi.x) ;
	float body = (VERTEX.y + 1.0) / 2.0; //for a fish centered at (0, 0) with a length of 2

	float mask = smoothstep(mask_black, mask_white, body);
	VERTEX.x += cos(time) * side_to_side * mask;
	COLOR.xyz = noi * vec3(mask) * 2.0;
}

void fragment(){
 	ALBEDO = COLOR.xyz * grass_color.xyz;
}