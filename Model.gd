extends KinematicBody2D

#All variables are described here
var swingdelay = 0
var menu_on = false
var menu_delay = 0
var minheight = true
var current_degrees


var delay = 0
var hitdelay = 0

#Variables for the players
var hp = 500
var attack = 1
var defense = 1
var speed = 250
var dead = 0 #If its 0, the functions in _process run, if it's 1, they do not

func dash():
	if Input.is_action_just_pressed("ability1") and delay == 0 and (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")):
		speed = 700
		delay = 20
		$"Dash Sound".play()
		$CPUParticles2D.emitting = true
		
	if delay == 10:
		speed = 250
		$CPUParticles2D.emitting = false
	
		
	if delay > 0:
		delay -= 1

#This function controls the collisionshape and animation of the sword playing
func move_and_rotate():
	var position1 = [0,0]
	
	if Input.is_action_pressed("ui_left"):
		position1[0] -= 1

	if Input.is_action_pressed("ui_right"):
		position1[0] += 1

	if Input.is_action_pressed("ui_up"):
		position1[1] -= 1
		
	if Input.is_action_pressed("ui_down"):
		position1[1] += 1
	
	#Can't use Vector2() in comparison operators as it causes an error i can't fix yet
	#And can't use a two element array and add it to position, as position is a Vector2() object
	var position2 = Vector2()
	position2.x = position1[0]*speed
	position2.y = position1[1]*speed
	
# warning-ignore:return_value_discarded
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
	
	#This code is here so that while the sword is swinging, the player cannot change the direction the character is facing
	if $"SwordObject/Sword Model".is_playing():
		rotation_degrees = current_degrees
	else:
		current_degrees = rotation_degrees
		
#This function is used to swing the sword and activate the collision box of the sword
func swordswing():
	if swingdelay != 0:
		swingdelay -= 1
	
	if Input.is_action_pressed("ui_accept") and swingdelay == 0:
		$"SwordObject/Sword Model".play("Swing")
		$SwordObject/Sword_collision.disabled = false
	
	if $"SwordObject/Sword Model".frame == 6:
		$"SwordObject/Sword Model".stop()
		$"SwordObject/Sword Model".frame = 0
		swingdelay = 16
		$SwordObject/Sword_collision.disabled = true

func _on_SwordObject_area_entered(area):
	
	area.hp -= attack
	area.hitdelay = 16
	
	if area.hp <= 0:
		area.free()
	
#This function controls how fast the menu opens and closes
func menu_show():
	if Input.is_action_pressed("ui_cancel") and menu_delay == 0:
		if menu_on == true:
			menu_on = false
		elif menu_on == false:
			#We reset the rotation of the player so that the menu does not rotate with it
			rotation_degrees = 0
			menu_on = true
		
		menu_delay = 20
	#If elif statement is excluded, menu_delay variable would go below 0 because the function runs every frame
	elif menu_delay > 0:
		menu_delay -= 1
		
	if menu_on == true:
		$"outer border".show()
		border_move()
	if menu_on == false:
		$"outer border".hide()
	


#This function expands and reduces the size of the menu in order to emulate an animation
func border_move():
	if minheight == true:
		$"outer border".scale.x += 0.0002
		$"outer border".scale.y += 0.0002
		$"outer border".scale = Vector2(stepify($"outer border".scale.x,0.0001),stepify($"outer border".scale.y,0.0001))
	
	if minheight == false :
		$"outer border".scale.x -= 0.0002
		$"outer border".scale.y -= 0.0002
		$"outer border".scale = Vector2(stepify($"outer border".scale.x,0.0001),stepify($"outer border".scale.y,0.0001))
	
	if $"outer border".scale == Vector2(1.0000,1.0000):
		minheight = true
	
	if $"outer border".scale == Vector2(1.0100,1.0100):
		minheight = false
		
 
		
func _ready():
	$"outer border".hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _physics_process(delta):
	if dead == 0:
		if menu_on == false:
			move_and_rotate()
	
			swordswing()
	
			dash()

		menu_show()
