extends Node

# Preload all ability scripts once so they’re ready to use
var registered_abilities = {
	"trombone": preload("res://Scripts/Abilities/dashAbility.gd"),
	"cymbals": preload("res://Scripts/Abilities/wallJumpAbility.gd"),
	"bongos": preload("res://Scripts/Abilities/double_jump.gd"),
	"tuba": preload("res://Scripts/Abilities/slamAbility.gd")
}

var current_ability: Node = null
var current_name: String = ""

func register_ability(name: String, ability_script: Resource):
	# This is optional now, since we already have them in registered_abilities
	registered_abilities[name] = ability_script

func unlock(name: String, player: CharacterBody2D):
	# Remove old ability
	if current_ability:
		current_ability.queue_free()

	# Check if we know this ability
	if not registered_abilities.has(name):
		push_warning("Unknown ability: %s" % name)
		return

	# Instantiate the ability
	var ability_script = registered_abilities[name]
	var new_ability = ability_script.new()
	player.add_child(new_ability)
	current_ability = new_ability
	current_name = name

	# Reset or refresh usage
	if new_ability.has_method("on_equipped"):
		new_ability.on_equipped(player)

	print("Equipped new ability:", name)

func update_all(player, delta):
	if current_ability and current_ability.has_method("update"):
		current_ability.update(player, delta)
		
func get_ability(name: String) -> bool:
	if(name == current_name):
		return true
	else:
		return false
