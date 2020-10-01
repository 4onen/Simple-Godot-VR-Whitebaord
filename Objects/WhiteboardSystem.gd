extends Spatial

const whiteboard := preload("res://Objects/Whiteboard/Whiteboard.tscn")
const carouselOffset := 3.0

func _board_count():
	return $WhiteboardOrigin/WhiteboardCarouselOffset.get_child_count()

func _selected_board():
	return int(floor(-$WhiteboardOrigin/WhiteboardCarouselOffset.translation.x/carouselOffset))

func _ready():
	var userdir = Directory.new()
	var err = userdir.open("user://")
	assert(not err)
	if not userdir.dir_exists("Whiteboard"):
		err = userdir.make_dir("Whiteboard")
		assert(not err)
	
	err = userdir.change_dir("Whiteboard")
	assert(not err)
	err = userdir.list_dir_begin(true,true)
	assert(not err)
	var boardFiles := PoolStringArray()
	var el : String = userdir.get_next()
	while not el.empty():
		boardFiles.push_back(el)
		el = userdir.get_next()
	
	if boardFiles.empty():
		newBoard()
	else:
		for name in boardFiles:
			newBoard(name.trim_suffix(".png"))

func newBoard(name : String = ""):
	if name.empty():
		name = "Whiteboard"+String(_board_count())
	
	var newboard := whiteboard.instance()
	newboard.name = name
	newboard.translation.x = carouselOffset*_board_count()
	$WhiteboardOrigin/WhiteboardCarouselOffset.add_child(newboard)

func _on_SaveButton_button_down():
	for board in $WhiteboardOrigin/WhiteboardCarouselOffset.get_children():
		board.save()

func _on_LoadButton_button_down():
	var selectedBoard := $WhiteboardOrigin/WhiteboardCarouselOffset.get_child(_selected_board())
	assert(selectedBoard)
	selectedBoard.reload()

func _on_LeftButton_button_down():
	var selectedIdx : int = _selected_board()
	assert(selectedIdx >= 0)
	if selectedIdx-1 >= 0:
		$WhiteboardOrigin/WhiteboardCarouselOffset.translation.x = -carouselOffset*(selectedIdx-1)

func _on_RightButton_button_down():
	var selectedIdx : int = _selected_board()
	var board_count : int = _board_count()
	assert(selectedIdx < board_count)
	if selectedIdx+1 == board_count:
		newBoard()
	
	$WhiteboardOrigin/WhiteboardCarouselOffset.translation.x = -carouselOffset*(selectedIdx+1)
