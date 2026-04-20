extends Node
var gameData = preload("res://Resources/GameData.tres")

var scene_map : Dictionary
var transitions : Array[Dictionary]
# ["from_map"="","to_map"="",transition_node=""]
var inject_scenes : Array

func _ready() -> void:
    if Engine.has_meta("nt_Loader"):
        print("[NT_LOADER] nt_Loader already initialized by other mod. This is fine.")
        queue_free()
        return
    
    Engine.set_meta("nt_Loader", self)
    print("[NT_LOADER] nt_Loader initialized.")

# Register a scene to be injected when loading a specific map. This would include transition points etc.
func RegisterInjectedScene(map_name : String, scene : PackedScene) -> void:
    var inject_data : Dictionary
    inject_data["map_name"] = map_name
    inject_data["scene"] = scene
    inject_scenes.append(inject_data)

# Register a custom scene, this will be the map name and path as well as parameters for your custom map.
func RegisterCustomScene(map_name : String, scene_path : String, shelter : bool = false, permadeath : bool = false) -> void:
    var scene_data : Dictionary
    scene_data.path = scene_path
    scene_data.shelter = shelter
    scene_data.permadeath = permadeath
    scene_map[map_name] = scene_data

# Register any new transition points
#transition_node_name is the exact name of the transition point IN THE ARRIVAL MAP, this is the place the character will spawn going from from_map_name to to_map_name
func RegisterSceneTransition(from_map_name : String, to_map_name : String, transition_node_name : String):
    var dic : Dictionary
    dic["from_map"] = from_map_name
    dic["to_map"] = to_map_name
    dic["transition_node"] = transition_node_name
    transitions.push_back(dic)

# Handles custom scene loading, any custom scenes must first be registered with RegisterCustomScene, this is called from Transition:Interact() which is overriden.
func LoadCustomScene(nextMap : String):
    var scenePath : String = scene_map[nextMap].path
    print("LoadCustomScene")
    Loader.label.show()
    Loader.circle.show()
    Loader.label.text = "Loading " + nextMap + "..."
    Loader.FadeInLoading()
    gameData.freeze = true
    
    gameData.menu = false
    gameData.shelter = scene_map[nextMap].shelter
    gameData.permadeath = scene_map[nextMap].permadeath
    gameData.tutorial = false

    await get_tree().create_timer(2.0).timeout;
    get_tree().change_scene_to_file(scenePath)
