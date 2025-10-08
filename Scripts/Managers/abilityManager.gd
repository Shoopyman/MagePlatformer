extends Node
class_name AbilityManager

var abilities := {}
var unlocked := {}

func _ready():
	# register the children
	for child in get_children():
		if child is Node and child.has_method("update"):
			#condition for abilities
			register_ability(child.name, child)

#register ability instance
func register_ability(name: String, ability: Node) -> void:
	if abilities.has(name):
		# if someone picks up an ability they already have
		push_warning("Ability already registered: %s" %name)
		return
	abilities[name] = ability
	ability.name = name
	if ability.get_parent() != self:
		add_child(ability)
		#shouldnt  be called but just in case
	unlocked[name] = false
	# dont call update unless unlocked
	ability.set_process(false)
	
func unlock(name: String) -> void:
	print("unlock called")
	if not abilities.has(name):
		# if someone picks up an ability they already have
		push_warning("Ability already registered: %s" %name)
		return
	if unlocked.get(name, false):
		return
	unlocked[name] = true
	print("set to true")
	var ab = abilities[name]
	ab.set_process(true)
	if ab.has_method("on_unlock"):
		ab.on_unlock()
		
func lock(name: String) -> void:
	if abilities.has(name):
		unlocked[name] = false
		abilities[name].set_process(false)

func is_unlocked(name: String) -> bool:
	return unlocked.get(name, false)
	
func get_ability(name: String) -> Node:
	return abilities.get(name, null)
	
func update_all(player, delta) -> void:
	for name in abilities.keys():
		if is_unlocked(name):
			var ab = abilities[name]
			if ab and ab.has_method("update"):
				ab.update(player, delta)
