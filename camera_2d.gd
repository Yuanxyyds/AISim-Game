extends Camera2D

@export var tile_size = 8
@export var map_width_tiles = 100
@export var map_height_tiles = -65  # Number of tiles in height

func _ready():
	# Calculate total map size
	var width_pixels = map_width_tiles * tile_size
	var height_pixels = map_height_tiles * tile_size
	
	# Center the camera
	position = Vector2(width_pixels / 2, height_pixels / 2)
	
	# Set camera limits
	limit_left = 0
	limit_top = height_pixels
	limit_right = width_pixels
	limit_bottom = 0

	# Disable zoom
	zoom = Vector2(2,2)
