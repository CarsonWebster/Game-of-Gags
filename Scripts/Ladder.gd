extends Area2D

func _on_body_entered(body):
	print("entering: ", body)
	if body.name == "Player":
		body.set_climbing(true)

func _on_body_exited(body):
	print("exiting: ", body)
	if body.name == "Player":
		body.set_climbing(false)
