class_name PlayerStatHandler
extends Node2D

var current_bananas: int = 0
var current_pies: int = 0
var current_shocks: int = 0

func _ready():
	CollectableSignalBus.banana_collected.connect(on_banana_collected)
	CollectableSignalBus.pie_collected.connect(on_pie_collected)
	CollectableSignalBus.shock_collected.connect(on_shock_collected)
	
	CollectableSignalBus.emit_on_update_banana(current_bananas)
	CollectableSignalBus.emit_on_update_pie(current_pies)
	CollectableSignalBus.emit_on_update_shock(current_shocks)

func on_banana_collected(resource: BaseCollectableResource) -> void:
	current_bananas += resource.value
	CollectableSignalBus.emit_on_update_banana(current_bananas)

func on_pie_collected(resource: BaseCollectableResource) -> void:
	current_pies += resource.value
	CollectableSignalBus.emit_on_update_pie(current_pies)

func on_shock_collected(resource: BaseCollectableResource) -> void:
	current_shocks += resource.value
	CollectableSignalBus.emit_on_update_shocks(current_shocks)
