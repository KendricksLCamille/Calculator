extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Calculator_resized():
	return
	var parent_width = rect_size.x
	var multiplier = [.25, .75]
	var positions = [0, rect_size.y * .25]
	for index in range(0,get_child_count()):
		var child:Control = get_children()[index]
		var width = parent_width/ multiplier[index]
		var child_width = child.rect_size.x
		var _scale = width/ child_width
		child.rect_position = Vector2(0, positions[index])
		child.rect_scale = Vector2(_scale, _scale) if _scale > 1 else Vector2.ONE
