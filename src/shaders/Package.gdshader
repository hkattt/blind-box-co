shader_type canvas_item;

uniform sampler2D mask_texture : hint_default_white;
uniform vec2 mask_position;
uniform vec2 mask_size;

void fragment() {
    vec2 uv = (SCREEN_UV - mask_position) / mask_size;
    vec4 mask = texture(mask_texture, uv);
    
    // Only show where the mask alpha is > 0.5
    if (mask.a < 0.5) {
        discard;
    }

    COLOR = texture(TEXTURE, UV) * COLOR;
}
