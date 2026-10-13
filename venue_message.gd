extends Label

const FLASH_INTERVAL := 0.12
const RAINBOW_COLORS := 7
const SWAY_ANGLE := 8.0
const SWAY_SPEED := 2.5
const DISPLAY_DURATION := 3.0

var elapsed := 0.0


func _ready() -> void:
	resized.connect(_update_layout)
	_update_layout()
	_update_animation()


func _process(delta: float) -> void:
	elapsed += delta
	if elapsed >= DISPLAY_DURATION:
		hide()
		set_process(false)
		return
	_update_animation()


func _update_layout() -> void:
	pivot_offset = size * 0.5
	var font := get_theme_font("font")
	var text_width := font.get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, 32).x
	add_theme_font_size_override("font_size", int(clampf(80.0 * size.x / text_width, 32.0, 80.0)))


func _update_animation() -> void:
	var color_index := int(elapsed / FLASH_INTERVAL) % RAINBOW_COLORS
	self_modulate = Color.from_hsv(float(color_index) / RAINBOW_COLORS, 0.85, 1.0)
	rotation = deg_to_rad(SWAY_ANGLE) * sin(elapsed * SWAY_SPEED)
