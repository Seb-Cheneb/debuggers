@icon("./debugger.png")
class_name Debugger 
extends Node


func get_class_name(object: Object) -> String:
	return object.get_script().get_path().get_file().get_basename()


func get_calling_method() -> String:
	var stack = get_stack()
	if stack.size() >= 3:  # Skip get_calling_method() and log_info()
		return stack[2]["function"]
	return "unknown_method"


func info(_is_debugging: bool, _class: Object, _message: String) -> void:
	if not _is_debugging:
		return
	print_rich("[color=orange]", get_class_name(_class), "[/color].[color=yellow]", get_calling_method(), "[/color] - ", _message)


func warn(_is_debugging: bool, _class: Object, _message: String) -> void:
	if not _is_debugging:
		return
	print_rich("[color=orange]", get_class_name(_class), "[/color].[color=yellow]", get_calling_method(), "[/color] - [color=red]", _message, "[/color]")


## Check multiple objects for null values
## Usage: check_objects(is_debugging, self, {"actor": actor, "shape_cast": shape_cast})
func check_objects(is_debugging: bool, _class: Object, objects: Dictionary) -> bool:
	var all_valid = true
	for object_name in objects:
		if not objects[object_name]:
			warn(is_debugging, _class, object_name + " not set")
			all_valid = false
	return all_valid

# Alternative version that takes individual objects with names
# Usage: check_objects_named(is_debugging, self, "actor", actor, "shape_cast", shape_cast)
func check_objects_named(is_debugging: bool, _class: Object, names_and_objects: Array) -> bool:
	var all_valid = true
	for i in range(0, names_and_objects.size(), 2):
		if i + 1 >= names_and_objects.size():
			break
		var object_name = names_and_objects[i]
		var object_value = names_and_objects[i + 1]
		if not object_value:
			warn(is_debugging, _class, object_name + " not set")
			all_valid = false
	return all_valid
