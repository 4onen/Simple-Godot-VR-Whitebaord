extends StaticBody

export (PackedScene) var tool_scene

func _ready():
	assert(tool_scene)
	var scn = tool_scene.instance()
	scn.translation.y += 0.1
	add_child(scn)
