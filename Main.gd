extends Spatial

onready var interface : ARVRInterface = ARVRServer.find_interface("OpenVR")

func _ready():
	if interface && interface.initialize():
		# Make sure Godot knows size of viewport, else only known by render driver
		$"Viewport-VR".size = interface.get_render_targetsize()
		
		# Tell viewport it is ar/vr
		$"Viewport-VR".arvr = true
		
		# Set to false if using older OpenVR drivers
		$"Viewport-VR".hdr = true
		
		# turn off vsync
		OS.vsync_enabled = false
		
		# Bump up physics engine speed
		Engine.target_fps = 90
		
		# Tell our display what to display
		$"ViewportContainer/Viewport-UI".set_viewport_texture($"Viewport-VR".get_texture())
