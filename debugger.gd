@icon("./debugger.png")
class_name Debugger extends Node


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
	print_rich("[color=orange]", get_class_name(_class), "[/color].[color=yellow]", get_calling_method(), "[/color] --- ", _message)


func warn(_is_debugging: bool, _class: Object, _message: String) -> void:
	if not _is_debugging:
		return
	print_rich("[color=orange]", get_class_name(_class), "[/color].[color=yellow]", get_calling_method(), "[/color] --- [color=red]", _message, "[/color]")
