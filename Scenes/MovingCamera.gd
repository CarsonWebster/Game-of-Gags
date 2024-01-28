extends Area2D

@onready var corrners = $Corrners

# Called when the node enters the scene tree for the first time.
func _ready():
	print(corrners)
	print(corrners.get_children())
	move_camera(corrners.get_children().pick_random().position)

func move_camera(pos: Vector2):
	print("Moving camera to: ", pos)
	var tween = get_tree().create_tween()
	tween.tween_property($".", "position", pos, 5)
	#tween.tween_callback($".".move_camera(corrners.get_children().pick_random().position))
	tween.connect("finished", on_tween_finished)

func on_tween_finished():
	print("Tween done!")
	await get_tree().create_timer(2).timeout
	move_camera(corrners.get_children().pick_random().position)
