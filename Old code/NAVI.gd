extends Navigation2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var a = 0
func _process(delta):

	if a == 0:
		for enemy in get_parent().get_children():
			
			if enemy is Navigation2D:
				continue
				
			var path = get_simple_path(enemy.position, get_parent().get_parent().get_node("Player").position)
			enemy.path = path
			#uncomment the line below to get a line that describes the path of navigation2d
			#$Line2D.points = path
			a = 20
		
	else: 
		a -= 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
