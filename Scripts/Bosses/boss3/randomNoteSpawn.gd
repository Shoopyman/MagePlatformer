extends Node2D

@export var quarterNote: PackedScene #1
@export var eighthNote: PackedScene #2
@export var halfNote: PackedScene #3
@export var wholeNote: PackedScene #4
@export var largeQuarterNote: PackedScene 
@export var largeEighthNote: PackedScene 
@export var largeHalfNote: PackedScene 
@export var largeWholeNote: PackedScene 
@export var spawn_interval: float = .20  # seconds between spawns
@export var max_attempts: int = 20


var note_radii = {
	"quarter": 16,
	"eighth": 39,
	"half": 16,
	"whole": 28
}

var spawn_timer = 0.0
var phase = 0

func _physics_process(delta: float) -> void:
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_random_note()
	
func spawn_random_note():
	var randomNumber: int = randi_range(1,4)
	var obj: Node2D
	var radius: float = 0.0
	
	if(TheaterManager.phase == 0):
		if randomNumber == 1:
			obj = quarterNote.instantiate()
			radius = note_radii["quarter"]
		if randomNumber == 2:
			obj = eighthNote.instantiate()
			radius = note_radii["eighth"]
		if randomNumber == 3:
			obj = halfNote.instantiate()
			radius = note_radii["half"]
		if randomNumber == 4:
			obj = wholeNote.instantiate()
			radius = note_radii["whole"]
		var pos = get_random_position_in_area()
		obj.position = pos
		add_child(obj)
	elif TheaterManager.phase == 1:
		if randomNumber == 1:
			obj = largeQuarterNote.instantiate()
			radius = note_radii["quarter"] * 2
		if randomNumber == 2:
			obj = largeEighthNote.instantiate()
			radius = note_radii["eighth"] *2
		if randomNumber == 3:
			obj = largeHalfNote.instantiate()
			radius = note_radii["half"] * 2
		if randomNumber == 4:
			obj = largeHalfNote.instantiate()
			radius = note_radii["whole"] * 2
		var pos = get_random_position_in_area()
		obj.position = pos
		add_child(obj)

func get_random_position_in_area() -> Vector2:
	var shape = $Area2D/CollisionShape2D.shape
	var area_pos = $Area2D.position
	if shape is RectangleShape2D:
		var extents = shape.extents
		return area_pos + Vector2(randf_range(-extents.x, extents.x),randf_range(-extents.y, extents.y))
	return area_pos
	
