extends Node
var nt_Loaderx : Node

func RefreshMenu() -> void:
    var menu = get_tree().root.get_node("Menu")
    menu.DeactivateButtons()
    menu.blocker.mouse_filter = menu.MOUSE_FILTER_STOP
    get_tree().change_scene_to_file(Loader.Menu)
    print("[NT_SCENELOADER] Menu refreshed.")

func _ready():
    nt_Loaderx = Engine.get_meta("nt_Loader")
    if(!nt_Loaderx):
        print("[NT_SCENELOADER] ERROR: nt_Loader not loaded.")
        return
    
    var mypath : String = self.get_script().resource_path
    overrideScript(mypath.replace("Main.gd", "overloads/Compiler.gd"))
    overrideScript(mypath.replace("Main.gd", "overloads/Transition.gd"))
    overrideScript(mypath.replace("Main.gd", "overloads/Menu.gd"))
    overrideScript(mypath.replace("Main.gd", "overloads/Death.gd"))
    
    var menu = get_tree().root.get_node("Menu")
    if !menu.get("nt_Loaderx"): # if menu needs to be refreshed
        if menu.is_node_ready():
            RefreshMenu()
        else:
            await menu.ready
            RefreshMenu()
        
    queue_free()

func overrideScript(path: String):
    var script: Script = load(path)
    script.reload()
    var parent = script.get_base_script()
    script.take_over_path(parent.resource_path)
