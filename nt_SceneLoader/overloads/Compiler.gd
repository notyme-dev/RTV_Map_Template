extends "res://Scripts/Compiler.gd"

var nt_Loaderx : Node
func _ready() -> void:
    nt_Loaderx = Engine.get_meta("nt_Loader")
    super()

func InjectScenes() -> void:
    for inj in nt_Loaderx.inject_scenes:
        if gameData.currentMap == inj.map_name:
            get_tree().root.get_node("Map").add_child(inj.scene.instantiate())
            inj.owner = get_tree().root
            
# Transition:Spawn() Override
func Spawn():
    InjectScenes()
    var spawnTarget: String
    var spawnPoint: Node3D
    var map = get_tree().current_scene.get_node("/root/Map")
    var transitions = get_tree().get_nodes_in_group("Transition")
    var waypoints = get_tree().get_nodes_in_group("AI_WP")

    if waypoints.size() != 0 && map.mapName != "Template":
        controller.global_position = waypoints.pick_random().global_position
        controller.global_rotation.y = randf_range(0, 360)

    else:
        controller.global_position = Vector3(0, 2, 0)

    var shelter_entry : String = ""
    for trans in nt_Loaderx.transitions:
        if trans["to_map"] == map.mapName:
            shelter_entry = trans["transition_node"]
            if trans["from_map"] == gameData.previousMap:
                spawnTarget = trans["transition_node"]
                break
                
    if !spawnTarget && gameData.shelter:
        spawnTarget = shelter_entry
            
    if nt_Loaderx.scene_map.has(map.mapName) and gameData.shelter:
            Loader.LoadShelter(map.mapName)
    
    if spawnTarget != "": # found custom spawn point
        for transition in transitions:
            if transition.owner.name == spawnTarget:
                spawnPoint = transition.owner.spawn
                if spawnPoint:
                    controller.global_transform.basis = spawnPoint.global_transform.basis
                    controller.global_transform.basis = controller.global_transform.basis.rotated(Vector3.UP, deg_to_rad(180))
                    controller.global_position = spawnPoint.global_position

        
        gameData.isTransitioning = false
        gameData.isSleeping = false
        gameData.isOccupied = false
        gameData.freeze = false
        
        Loader.LoadWorld()
        Loader.LoadCharacter()
        Simulation.simulate = true

        if gameData.difficulty == 1 && gameData.permadeath:
            await get_tree().create_timer(1.0, false).timeout;
            PlayVostokEnter()
    else: #no custom spawn point found
        super()
