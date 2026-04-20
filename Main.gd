extends Node
var nt_Loaderx : Node

const map_name : String = "My Map"
const shelter : bool = true
const permadeath : bool = false

####### ---DEBUG FUNCTIONS (ONLY FOR TESTING)--- #######

func LoadFromToCustom(from_map : String, to_map : String) -> void:
    var gd : GameData = load("res://Resources/GameData.tres")
    Simulation.simulate = true
    gd.currentMap = to_map
    gd.previousMap = from_map
    nt_Loaderx.LoadCustomScene(to_map)
    
func LoadFromTo(from_map : String, to_map : String) -> void:
    var gd : GameData = load("res://Resources/GameData.tres")
    Simulation.simulate = true
    gd.currentMap = to_map
    gd.previousMap = from_map
    Loader.LoadScene(to_map)
    
####### --------------------------------------- #######

func _ready() -> void:
    print(Engine.get_meta("nt_Loader"))
    nt_Loaderx = Engine.get_meta("nt_Loader")
    if(!nt_Loaderx):
        print("[NT_LOADER] ERROR: nt_Loader not found.")
        return
    
    nt_Loaderx.RegisterCustomScene(map_name, "res://mods/MapTemplate/MyMap/MyMap.scn", shelter, permadeath)
    nt_Loaderx.RegisterSceneTransition("Village", map_name, "Transition_Village")
    nt_Loaderx.RegisterSceneTransition(map_name, "Village", "Transition_MyMap")
    
    var village_inject_scene = load("res://mods/MapTemplate/Village_Inject.tscn")
    nt_Loaderx.RegisterInjectedScene("Village", village_inject_scene)
    
    if get_tree().root.has_node("Menu"):
        var menu = get_tree().root.get_node("Menu")
        menu._ready()
    
    #wait for nonsense
    await get_tree().create_timer(2).timeout
    
    #LoadFromTo("Cabin", "Village")
    queue_free()
