extends KinematicBody2D



var swingdelay = 0
func swordswing():
	if swingdelay != 0:
		swingdelay -= 1
	
	if Input.is_action_pressed("ui_accept") and swingdelay == 0:
		$"SwordObject/Sword Model".play("Swing")
		$SwordObject/Sword_collision.disabled = false
	
	if $"SwordObject/Sword Model".frame == 6:
		$"SwordObject/Sword Model".stop()
		$"SwordObject/Sword Model".frame = 0
		swingdelay = 20
		$SwordObject/Sword_collision.disabled = true


func _ready():
	$SwordObject/Sword_collision.disabled = true

var speed = 300
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Globals.hero_hp == 0:
		print("Me dead")
	#Code recycled from the Node2d script because I don't know how to import variables from other s
	var position1 = [0,0]
	
	if Input.is_action_pressed("ui_left"):
		position1[0] -= 1

	if Input.is_action_pressed("ui_right"):
		position1[0] += 1

	if Input.is_action_pressed("ui_up"):
		position1[1] -= 1
		
	if Input.is_action_pressed("ui_down"):
		position1[1] += 1
	
		
	swordswing()
	#Can't use Vector2() in comparison operators as it causes an error i can't fix yet
	#And can't use a two element array and add it to position, as position is a Vector2() object
	var position2 = Vector2()
	position2.x = position1[0]*speed
	position2.y = position1[1]*speed
	
	move_and_slide(position2)
	
	
	#This code changes the rotation of the player model according to which direction the player is moving
	if position1 != [0,0]:
		$Model.play("walk")
	else:
		$Model.stop()
		$Model.frame = 0
		
	if position1 == [1,1]:
		rotation_degrees = 135
	elif position1 == [-1,-1]:
		rotation_degrees = -45
	elif position1 == [-1,1]:
		rotation_degrees = -135
	elif position1 == [1,-1]:
		rotation_degrees = 45
	
	elif position1 == [1,0]:
		rotation_degrees = 90
	elif position1 == [0,1]:
		rotation_degrees = -180
	elif position1 == [-1,0]:
		rotation_degrees = -90
	elif position1 == [0,-1]:
		rotation_degrees = 0


func _on_SwordObject_body_entered(body):
	print(body)



func _on_DamageHim_area_entered(area):
	if area == $Area2D:
		print("Oof")
