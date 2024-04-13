shader_type canvas_item;

void fragment() {
	float line_height = 2.0;
	float intensity = 0.0;

	if (int(mod(FRAGCOORD.y, line_height)) == 0) {
        // インターレースの線に当たる部分
        COLOR = texture(TEXTURE, UV) * intensity;
    } else {
        // 通常の表示
        COLOR = texture(TEXTURE, UV);
    }
}
