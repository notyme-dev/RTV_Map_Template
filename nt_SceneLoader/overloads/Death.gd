extends "res://Scripts/Death.gd"

var nt_Loaderx : Node
func _ready() -> void:
    nt_Loaderx = Engine.get_meta("nt_Loader")
    super()

func _on_load_pressed():
    if nt_Loaderx.scene_map.has(Loader.ValidateShelter()):
        nt_Loaderx.LoadCustomScene(Loader.ValidateShelter())
        PlayClick()
        blocker.mouse_filter = MOUSE_FILTER_STOP
    else:
        super()
