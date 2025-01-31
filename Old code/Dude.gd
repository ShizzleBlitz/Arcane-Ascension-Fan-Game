extends Area2D
var speed = 50
var path : = PoolVector2Array()
var hp = 50
var stop = 0
var hitdelay = 0 #this variable is just here so that the enemy gets knocked back a few spaces in a few frames
var count = 1 #used so i can add all the signals from the enemies entering the players collisionbox to the knockback method

func knockback(delta):	
	if hitdelay > 0:
		hitdelay -= 1
		position -= 10*delta*speed*position.direction_to(get_parent().get_parent().get_node("Player").position)
	
func Playerknockback(delta):
	var Player = get_parent().get_parent().get_node("Player")
	if Player is KinematicBody2D:	
		if Player.hitdelay > 0:
			Player.hitdelay -= 1
			#Player.position -= 10*delta*speed*Player.position.direction_to(position)
			Player.move_and_collide(-10*delta*speed*Player.position.direction_to(position))
		
func move_and_rotate(delta):
	var distance_to_walk = speed * delta
	# Move the player along the path until he has run out of movement or the path ends.
	while distance_to_walk > 0 and path.size() > 0:
		var distance_to_next_point = position.distance_to(path[0])
		var position1 = [int(round(position.direction_to(path[0]).x)),int(round(position.direction_to(path[0]).y))]
		
		if distance_to_walk <= distance_to_next_point:
			# The player does not have enough movement left to get to the next point.
			position += position.direction_to(path[0]) * distance_to_walk
			
		else:
			# The player get to the next point
			position = path[0]
			path.remove(0) 
		# Update the distance to walk
		distance_to_walk -= distance_to_next_point
		
		if position1 != [0,0]:
			$Enemysprite.play("walk")
		elif position1 == [0,0]:
			$Enemysprite.stop()
			
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
		
		
func onenter(body):
	if body is KinematicBody2D:
		body.hitdelay = 16
		body.hp -= 1
		
		if body.hp == 0:
			#the second camera is there for when the first camera is destroyed by deleting the player node
			get_parent().get_parent().get_node("Death Camera").position = body.position
			get_parent().get_parent().get_node("Death Camera").current = true
			body.get_node("Model").hide()
			get_parent().get_node("EnemyNav/NavigationPolygonInstance").enabled = false
			

func _process(delta):

	if count == 1:
		for nodes in get_parent().get_children():
			if nodes is Area2D and nodes.is_connected("body_entered",self,"onenter") == false:
				nodes.connect("body_entered",self,"onenter")
		count = 0
		
		
	move_and_rotate(delta)
	
	knockback(delta)
	Playerknockback(delta)
