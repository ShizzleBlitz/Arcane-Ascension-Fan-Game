extends Navigation2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var navwait = 0
var enemyspeed = 200

func navget(delta):
	
	var movement = delta*enemyspeed
	var path = get_simple_path($Enemy.position, get_parent().get_node("Player").position)
	
	if navwait == 0:
		$Line2D.points = path
		navwait = 50
	else:
		navwait -= 1
	
	if movement > $Enemy.position.distance_to(path[0]):
		pass
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	navget(delta)
