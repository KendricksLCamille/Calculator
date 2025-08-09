extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var text_output = get_node("../TextOutput")

# Called when the node enters the scene tree for the first time.
func _ready():
	for vboxes in get_children():
		for child in vboxes.get_children():
			var control:Control = child
			var num_of_children = control.get_child_count()
			if child is Button:
					connect_button_text_to_text_output(child);
			else:
				for child2 in control.get_children():
					connect_button_text_to_text_output(child2)


func connect_button_text_to_text_output(button:Button):
	button.connect("pressed", text_output, "add_to_inner_text", [button.text])
	print(button.name + " was connected to " + text_output.name)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
