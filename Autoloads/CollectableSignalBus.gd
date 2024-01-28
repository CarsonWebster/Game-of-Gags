extends Node

signal collected(resource: BaseCollectableResource)

#region item type signals
signal banana_collected(resourece: BaseCollectableResource)
signal pie_collected(resourece: BaseCollectableResource)
signal shock_collected(resourece: BaseCollectableResource)

signal banana_dropped(resource: BaseCollectableResource)
signal pie_dropped(resource: BaseCollectableResource)
signal shock_dropped(resource: BaseCollectableResource)
#endregion

#region ui update signals
signal on_update_banana(value: int)
signal on_update_pie(value: int)
signal on_update_shock(value: int)
#endregion

func emit_on_update_banana(value: int) -> void:
	on_update_banana.emit(value)
func emit_on_update_pie(value: int) -> void:
	on_update_pie.emit(value)
func emit_on_update_shock(value: int) -> void:
	on_update_shock.emit(value)


func emit_banana_collected(resourece: BaseCollectableResource) -> void:
	banana_collected.emit(resourece)
func emit_banana_dropped(resource: BaseCollectableResource) -> void:
	banana_dropped.emit(resource)

func emit_pie_collected(resourece: BaseCollectableResource) -> void:
	pie_collected.emit(resourece)
func emit_pie_dropped(resource: BaseCollectableResource) -> void:
	pie_dropped.emit(resource)

func emit_shock_collected(resourece: BaseCollectableResource) -> void:
	shock_collected.emit(resourece)
func emit_shock_dropped(resource: BaseCollectableResource) -> void:
	shock_dropped.emit(resource)


func emit_on_collected(resourece: BaseCollectableResource) -> void:
	collected.emit(resourece)
