extends "res://Scripts/Menu.gd"

var nt_Loaderx : Node
func _ready():
    print("CUSTOM MENY READY")
    nt_Loaderx = Engine.get_meta("nt_Loader")
    super()
    
func _on_load_pressed():
    print("CUSTOM MENU LOAD")
    if nt_Loaderx.scene_map.has(Loader.ValidateShelter()):
        nt_Loaderx.LoadCustomScene(Loader.ValidateShelter())
        PlayClick()
        DeactivateButtons()
        blocker.mouse_filter = MOUSE_FILTER_STOP
        
    else:
        super()
