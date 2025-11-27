@tool
extends Node

# CONFIG: change this to the actual name/path of your TileMapLayer
@export var layer: TileMapLayer

const TILE_SIZE = 16

func _ready():
	if !Engine.is_editor_hint():
		return

	if layer == null:
		push_error("Assign your TileMapLayer in the Inspector!")
		return

	# Get used tile rectangle in tile units
	var used_rect = layer.get_used_rect()
	var width = used_rect.size.x * TILE_SIZE
	var height = used_rect.size.y * TILE_SIZE

	var img := Image.create(width, height, false, Image.FORMAT_RGBA8)
	img.fill(Color(0,0,0,0))

	for cell in layer.get_used_cells():
		var source_id = layer.get_cell_source_id(cell)
		var atlas_coords = layer.get_cell_atlas_coords(cell)

		var tileset = layer.tile_set
		var tile_source = tileset.get_source(source_id)
		var tex = tile_source.texture

		var region = Rect2(atlas_coords * TILE_SIZE, Vector2(TILE_SIZE, TILE_SIZE))
		var tile_img = tex.get_image().get_region(region)

		var pixel_pos = (cell - used_rect.position) * TILE_SIZE
		img.blit(tile_img, pixel_pos)

	img.save_png("res://exported_tilemap.png")
	print("Tilemap exported → res://exported_tilemap.png")
