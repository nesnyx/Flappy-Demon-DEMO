extends Node2D

export (Array,PackedScene) var scene_obstacle


onready var camera = $Camera2D
onready var obs_position = $obs_pos.position
onready var obs_y_position = [
	$obs_pos.position.y,
	$obs_y_pos_1.position.y,
	$obs_y_pos_2.position.y
]
onready var obs_container = $obs_container

onready var label_score = $Camera2D/score
onready var label_high_score = $Camera2D/high_score
onready var start_pos = $Camera2D.position.x

onready var label_game_over = $Camera2D/game_over


var level_speed = 1
var level_up = 0.1
var max_level_speed = 2
var next_level
var level_length = 100
var speed = 200
var score = 0
func camera_movement(delta):
	camera.position.x += speed *level_speed * delta
	
	
func obs_generator(amount):
	for i in amount:
		var type = randi() % 2
		var new_obs
		
		
		if type == 0:
			new_obs = scene_obstacle[type].instance() as Area2D
			new_obs.position = obs_position
		else:
			new_obs = scene_obstacle[type].instance() as Area2D
			new_obs.position.x = obs_position.x
			new_obs.position.y = obs_y_position[randi() % 3]
		
		if new_obs:
			new_obs.connect('player_hit_obstacle',self, 'player_hit_obstacle')
			obs_container.call_deferred("add_child",new_obs)
			obs_position.x += rand_range(200,350)

func player_hit_obstacle():
	get_tree().paused = true
	label_game_over.visible = true
	label_game_over.last_score = score

	
func _ready():
	randomize()
	next_level = level_length
	label_high_score.text = 'High Score :  ' + str(Global.high_score)
	obs_generator(50)

func score_update():
	score = int((camera.position.x - start_pos) / 10)
	label_score.text = str(score)


func _physics_process(delta):
	camera_movement(delta)
	score_update()
	level_update()

func level_update():
	if score < next_level:
		return
	
	if score > next_level:
		if level_speed < max_level_speed:
			level_speed += level_up
			next_level += level_length


func _on_obs_eraser_area_entered(area):
	area.queue_free()
	print(area)
