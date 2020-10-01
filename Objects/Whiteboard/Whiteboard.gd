extends StaticBody

func save():
	$Surface.save(name)

func reload():
	$Surface.reload(name)

func _ready():
	reload()
