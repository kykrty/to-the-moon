extends KinematicBody2D

# Constants

const accel = 1028
const maxspd = 128
const frctn = 0.2
const grav = 300
const jmpfrce = 200
const airres = 0.5

# Variables

var motion = Vector2.ZERO
var cTime1 = true
onready var sprite = $Sprite
onready var aniPlayer = $AnimationPlayer

# Physics shit

func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	motion.y += grav * delta 
	
	if x_input != 0:
		motion.x += x_input * accel * delta
		motion.x = clamp(motion.x, -maxspd, maxspd)
		sprite.flip_h = x_input < 0
		aniPlayer.play("run")
	else:
		aniPlayer.play("stand")
	
	motion.y += grav * delta 
	# This makes the character jump
	
	if is_on_floor():
		if x_input == 0:
			motion.x = lerp(motion.x, 0, frctn)
	
		if Input.get_action_strength("ui_up"):
				motion.y = -jmpfrce
		
	 # This essentially just gives the player air resistence, so it doesn't 
	# move after jumping while moving
	
		else:
			if Input.is_action_just_released("ui_up") and motion.y < -jmpfrce/2:
				motion.y = -jmpfrce/2
		
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, airres)
	
	motion = move_and_slide(motion, Vector2.UP)
	
# Room shit. It sucks that I have to do this but idk how else to

func _on_LVL_wrp_lvl2_body_entered(body):
	get_tree().change_scene("res://ROOM1.tscn")

func _on_DEATH_ROOM1_body_entered(body):
	get_tree().change_scene("res://ROOM1.tscn")

func _on_DEATH_ROOM2_body_entered(body):
	get_tree().change_scene("res://ROOM2.tscn")

func _on_Load_room_2_body_entered(body):
	get_tree().change_scene("res://ROOM2.tscn")

func _on_LOAD_ROOM3_body_entered(body):
	get_tree().change_scene("res://ROOM3.tscn")

func _on_Warp_room_4_body_entered(body):
	get_tree().change_scene("res://ROOM4.tscn")
	
func _on_Change_room_5_1_body_entered(body):
	get_tree().change_scene("res://ROOM5_1.tscn")

func _on_DOOR_body_entered(body):
	get_tree().change_scene("res://ROOM5_2.tscn")

func _on_LVL_WARP_7_body_entered(body):
	get_tree().change_scene("res://ROOM7.tscn")

func _on_warp_room_6_body_entered(body):
	get_tree().change_scene("res://ROOM6.tscn")
	
func _on_Go2RoomMoon1_body_entered(body):
	get_tree().change_scene("res://Room8.tscn")

func _on_GoToDaMoon_body_entered(body):
	get_tree().change_scene("res://THE_END.tscn")

