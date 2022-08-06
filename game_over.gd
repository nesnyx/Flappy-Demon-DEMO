extends Label

var last_score = 0


func _input(event):
	if visible:
		if event.is_action_pressed('jump'):
			get_tree().reload_current_scene()
			visible = not visible
			
	if last_score > Global.high_score:
		Global.high_score = last_score
		
