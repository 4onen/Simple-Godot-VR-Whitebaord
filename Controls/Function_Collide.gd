extends Spatial

const collider_scene := preload("res://Controls/Function_Collide_Collider.tscn")

func _ready():
	var parent := self.get_parent()
	assert(parent)
	var collider := collider_scene.instance()
	collider.target = self
	parent.call_deferred("add_child",collider)
