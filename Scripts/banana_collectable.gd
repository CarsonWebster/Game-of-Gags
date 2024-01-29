extends Node2D

@export var bananares: Resource

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#func _ready():
	#area_entered.connect(on_area_entered)
	#set_texture()
#
#func set_texture() -> void:
	#sprite_2d.texture = collectable_resource.texture
#


func _on_area_2d_area_entered(area):
	if area.owner.is_in_group("Player"):
		CollectableSignalBus.emit_banana_collected(bananares)
		queue_free()
	else:
		print("ERROR: --- NO PLAYER FOUND ---")
		print(area)
