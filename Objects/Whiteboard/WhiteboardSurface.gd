extends StaticBody

func _gen_path(name : String):
	return "user://Whiteboard/"+name+".png"

func draw(p_at,color:Color,size:=1.0):
	# Hit target at specified position
	var t := global_transform
	var at = t.xform_inv(p_at)
	
	# Adjust from 3D coords to 2D coords in viewport
	at.x = (0.5 + (at.x / $MeshInstance.mesh.size.x)) * $Viewport.size.x
	at.y = (0.5 - (at.y / $MeshInstance.mesh.size.y)) * $Viewport.size.y
	
	# Position mark at those coordinates
	$Viewport/Mark.rect_position = Vector2(at.x, at.y)
	
	# Render mark
	$Viewport/Background.visible = false
	$Viewport/Mark.modulate = color
	$Viewport/Mark.rect_scale = Vector2(size,size)
	$Viewport/Mark.visible = true
	$Viewport.render_target_update_mode = Viewport.UPDATE_ONCE

func save(name):
	var image := $Viewport.get_viewport().get_texture().get_data()
	image.convert(Image.FORMAT_RGB8)
	var err := image.save_png(_gen_path(name))
	assert(not err)

func reload(name):
	var image: Image = Image.new()
	print(_gen_path(name))
	var err := image.load(_gen_path(name))
	assert(not image.is_invisible())
	if not err:
		var tex := ImageTexture.new()
		tex.create_from_image(image)
		$Viewport/Background.texture = tex
		$Viewport/Mark.visible = false
		$Viewport/Background.visible = true
		$Viewport.render_target_update_mode = Viewport.UPDATE_ONCE
	
	

func _ready():
	var vp_material := SpatialMaterial.new()
	vp_material.albedo_texture = $Viewport.get_texture()
	$MeshInstance.material_override = vp_material
