extends Node2D

@onready var timer = $Timer
@onready var sprite = $AnimatedSprite2D

@export var pie_collectable: PackedScene
@export var pieres: Resource

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = randi_range(5, 15)
	sprite.hide()
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_timer_timeout():
	#print("Grandma time")
	sprite.play("Grandma")
	sprite.show()
	$Oven.play()


func _on_animated_sprite_2d_animation_finished():
	var pie = pie_collectable.instantiate()
	pie.collectable_resource = pieres
	$"../../EntityContainer".add_child(pie)
	pie.position = global_position
	pie.position.y += 10
	sprite.hide()

#func _on_banana_timer_timeout():
	#animated_sprite.play("Spawn")
	#$SpawnSound.play()
	#var banana = banana_collectable.instantiate()
	#banana.collectable_resource = bananares
	#$"../../EntityContainer".add_child(banana)
	#banana.position = global_position
	#banana.position += Vector2(randi_range(-10,10), randi_range(-10,10))
