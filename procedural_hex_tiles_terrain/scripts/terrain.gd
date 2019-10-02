extends Node2D

signal started
signal finished

var _rng = RandomNumberGenerator.new()

onready var _tilemap = $TileMap

const GRID_X_TILES = 16
const GRID_Y_TILES = 9
var size_units = Vector2(GRID_X_TILES,GRID_Y_TILES)

"""
this is the offsets with respect to the image size
we make in order for
the tilemap's Mode , square to function as hex grids
"""
const CUSTOM_OFFSET_X = 0
const CUSTOM_OFFSET_Y = 36 
func _ready() -> void:
    setup()
    return

func setup() -> void:
    var map_size_px = (size_units+Vector2(0.5,0)) * _tilemap.cell_size
    get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D,SceneTree.STRETCH_ASPECT_KEEP,map_size_px+Vector2(CUSTOM_OFFSET_X,CUSTOM_OFFSET_Y))
    generate()
func generate() -> void:
    emit_signal("started")
    _rng.randomize()
    for x in range(0,size_units.x):
        for y in range(0,size_units.y):
            var cell = get_random_tile()
            _tilemap.set_cell(x,y,cell)
    emit_signal("finished")
    
func get_random_tile() -> int:
    return _rng.randi_range(0,23)
    
func _unhandled_input(event:InputEvent) -> void:
    if event.is_action_pressed("click"):
        generate()