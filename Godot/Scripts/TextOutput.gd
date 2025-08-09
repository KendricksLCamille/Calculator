extends LineEdit



# Declare member variables here. Examples:
const operations = {"*":"multiply", "/": "divide","+": "add", "-": "minus"}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_to_inner_text(_char):
	text += _char
	
	if _char == "Clear":
		text = "";
	elif _char == "=":
		text = text.substr(0, len(text) - 1)
		var b = generate_calculation_tree(text);
		
		text = str(perform_calculations(b))
		pass

func generate_calculation_tree(input):
	var is_input_a_number_with_result = is_a_number_and_result(input)
	if(is_input_a_number_with_result["is_number"]):
		return is_input_a_number_with_result["result"]
	
	#PEMDAS is reversed since the last calculation occurs at the root 
	#and the earliest calculations(Multiply) occurs at the leaves
	var inverted_pemdas = operations.keys()
	inverted_pemdas.invert()
	for operation in inverted_pemdas:
		if not operation in input:
			continue
		
		var index_of_operation = input.find(operation)
		if index_of_operation == 0 or index_of_operation >= len(input):
			return null
		var left_of_operation = input.substr(0, index_of_operation)
		var right_of_operation = input.substr(index_of_operation + 1)
		
		return {
			"operation": operation, 
			"left": generate_calculation_tree(left_of_operation),
			"right": generate_calculation_tree(right_of_operation)
				}
	
func perform_calculations(input:Dictionary):
	var left = input["left"]
	var right = input["right"]
	var op = input["operation"]
	
	if typeof(left) == TYPE_DICTIONARY:
		left = perform_calculations(left)
	if typeof(right) == TYPE_DICTIONARY:
		right = perform_calculations(right)
		
	return call(operations[op], left, right);


func perform_operations(input = text, _result = 0):
	#original method that can't handle negative numbers
	return
	var operations = {"*":"multiply", "/": "divide","+": "add", "-": "minus"}
	
	if len(input.strip_edges()) == 0:
		return _result
	for operation in operations:
		var index = input.find(operation)
		if index == -1:
			continue;
		
		var left_op = "";
		var left_stop = index-1
		for i in range(0, index):
			var _char = input[index - 1 - i]
			if is_num(_char):
				left_op = _char + left_op
				left_stop = left_stop - 1
			else:
				break
				
		var right_op = "";
		var right_stop = index+1
		for i in range(index+1, len(input)):
			var _char = input[i]
			if is_num(_char):
				right_op = right_op + _char
				right_stop = right_stop + 1
			else:
				break
		
		_result = call(operations[operation], int(left_op), int(right_op))
		
		#var left_index = index + left_stop
		var left_side = "" if left_stop < 0 else input.substr(0, left_stop) + "+"
		

		var right_side = "" if right_stop >= len(input) else input.substr(right_stop)
		input = left_side + str(_result) + right_side
		return perform_operations(input, _result)
	return int(_result)
	
func add(op1, op2):
	return op1 + op2
	
func divide(op1, op2):
	return op1 / op2
	
func minus(op1, op2):
	return op1 - op2
	
func multiply(op1, op2):
	return op1 * op2
	
func is_num(_char):
	var _int = int(_char)
	return _char == str(_int)

func is_a_number_and_result(_text):
	var _float = float(_text)
	return {"is_number":_text == str(_float), "result": _float}
