extends Area2D

signal player_hit_obstacle

	


func _on_ghost_body_entered(body):
	if body.is_in_group('player'):
		emit_signal('player_hit_obstacle')