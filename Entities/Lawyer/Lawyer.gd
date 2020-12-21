extends Node2D

export var id = 0
signal collided(collision, id)
signal dead(id)

func _on_Lane_killed(kill_id):
	if id == kill_id:
		$KinematicBody2D.kill()

func _on_Tween_tween_all_completed():
	queue_free()
