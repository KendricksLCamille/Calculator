extends Container


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ChildStrechter_resized():
	return;
	var max_width = rect_size.x
	var max_height = rect_size.y*.25
	var child = $TextOutput
	var x_scale = max_width/ child.rect_size.x
	
	var scaled_size = child.rect_size * x_scale
	if get_rect().has_point(scaled_size):
		child.rect_scale = Vector2(x_scale, x_scale) if x_scale else Vector2.ONE
	
	
	pass # Replace with function body.
