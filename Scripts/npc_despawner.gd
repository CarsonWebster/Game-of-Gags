extends Area2D

func _on_area_entered(area):
		if area.name.begins_with("npc"):
			area.queue_free()
