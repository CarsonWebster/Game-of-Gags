extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus()

func get_focus():
	grab_focus()
	print("Got focus")
