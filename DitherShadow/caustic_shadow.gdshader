shader_type spatial;

render_mode unshaded;

uniform float caustic = 5.0; // The higher this is, the more the light is focused in the effect.

const int D = (1 << 13) - 1;  // 13 is prime to have a cyclic group
float ign(vec2 p)
{
    float v = mod(52.9829189f * mod(0.06711056f * p.x + 0.00583715f * p.y, 1.0f), 1.0f);
	return mod(v + float(int(TIME * 11003.0) % D) / float(D), 1.0);  // 11003 is a prime which works well
}

void fragment() {
	ALPHA = (1.0 - pow(dot(NORMAL, VIEW), caustic));
	ALPHA = ALPHA >= ign(SCREEN_UV * VIEWPORT_SIZE) ? 1.0 : 0.0;
	ALPHA_SCISSOR_THRESHOLD = 0.5;
}