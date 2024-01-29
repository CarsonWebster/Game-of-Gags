class_name BaseCollectable
extends Area2D

@export var collectable_resource: BaseCollectableResource = null

@onready var sprite_2d = $Sprite2D as Sprite2D

func _ready():
	area_entered.connect(on_area_entered)
	set_texture()

func set_texture() -> void:
	sprite_2d.texture = collectable_resource.texture

func on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		CollectableSignalBus.collected.emit(collectable_resource)
		queue_free()
	else:
		print("ERROR: --- NO PLAYER FOUND ---")
