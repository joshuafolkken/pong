shader_type canvas_item;

void fragment() {
    float line_height = 2.0; // 2ピクセルごとにラインを作成
    bool is_even = mod(FRAGCOORD.x, line_height * 2.0) >= line_height;

    if (is_even) {
        //COLOR = texture(TEXTURE, UV);
    } else {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0); // 黒い線
    }
}
