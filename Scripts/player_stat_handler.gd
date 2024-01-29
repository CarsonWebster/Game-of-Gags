class_name PlayerStatHandler
extends Node2D

var current_bananas: int = 10
var current_pies: int = 10
var current_shocks: int = 10

func _ready():
	CollectableSignalBus.banana_collected.connect(on_banana_collected)
	CollectableSignalBus.banana_dropped.connect(on_banana_dropped)
	CollectableSignalBus.pie_collected.connect(on_pie_collected)
	CollectableSignalBus.pie_dropped.connect(on_pie_dropped)
	CollectableSignalBus.shock_collected.connect(on_shock_collected)
	CollectableSignalBus.shock_dropped.connect(on_shock_dropped)
	
	CollectableSignalBus.emit_on_update_banana(current_bananas)
	CollectableSignalBus.emit_on_update_pie(current_pies)
	CollectableSignalBus.emit_on_update_shock(current_shocks)

func on_banana_collected(resource: BaseCollectableResource) -> void:
	current_bananas += resource.value
	CollectableSignalBus.emit_on_update_banana(current_bananas)
func on_banana_dropped() -> void:
	current_bananas -= 1
	CollectableSignalBus.emit_on_update_banana(current_bananas)

func on_pie_collected(resource: BaseCollectableResource) -> void:
	current_pies += resource.value
	CollectableSignalBus.emit_on_update_pie(current_pies)
func on_pie_dropped() -> void:
	current_pies -= 1
	CollectableSignalBus.emit_on_update_banana(current_bananas)


func on_shock_collected(resource: BaseCollectableResource) -> void:
	current_shocks += resource.value
	CollectableSignalBus.emit_on_update_shocks(current_shocks)
func on_shock_dropped() -> void:
	current_shocks -= 1
	CollectableSignalBus.emit_on_update_banana(current_bananas)
