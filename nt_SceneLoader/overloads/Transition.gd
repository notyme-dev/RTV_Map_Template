extends "res://Scripts/Transition.gd"

var nt_Loaderx : Node
func _ready():
    super()
    nt_Loaderx = Engine.get_meta("nt_Loader")

func Interact():
    # if custom map not detected don't override behavior.
    if !nt_Loaderx.scene_map.has(nextMap):
        super()
        return
    
    if locked:
        CheckKey()
        return

    Simulation.simulate = false
    if tutorialExit: Loader.LoadScene(nextMap)
    
    else:

        UpdateSimulation()
        Simulation.simulate = true


        gameData.currentMap = nextMap
        gameData.previousMap = currentMap
        gameData.energy -= energy
        gameData.hydration -= hydration

        
        nt_Loaderx.LoadCustomScene(nextMap) # NEW
        
        Loader.SaveCharacter()
        Loader.SaveWorld()

        if shelterExit: Loader.SaveShelter(currentMap)
        
