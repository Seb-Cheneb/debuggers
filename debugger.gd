@icon("./debugger.png")
class_name Debugger extends RefCounted


func get_class_name() -> String:
	return get_script().get_path().get_file().get_basename()
