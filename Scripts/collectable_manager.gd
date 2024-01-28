class_name CollectableManager
extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	CollectableSignalBus.collected.connect(on_collectable_collected)

func on_collectable_collected(resource: BaseCollectableResource) -> void:
	match resource.tag:
		"Banana":
			CollectableSignalBus.emit_banana_collected(resource)
		"Pie":
			CollectableSignalBus.emit_pie_collected(resource)
		"Shock":
			CollectableSignalBus.emit_shock_collected(resource)
		"":
			print("ERROR: ---- NO TAG SPECIFIED ----")
