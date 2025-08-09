extends Control


func _ready():
	for child in get_children():
		_set_text_to_name_if_button(child)
		for child2 in child.get_children():
			_set_text_to_name_if_button(child2)

func _set_text_to_name_if_button(button):
	if button is Button:
		button.text = button.name
