@tool
extends Node3D

@export var terrain : MeshInstance3D
@export var spawner_tree : Node3D
@export var waypoints : Node3D
@export var generate: bool = false: set = GenerateSurface
@export var clear: bool = false: set = ClearSurface
@export var black_surface : String = "Grass"
@export var red_surface : String = "Dirt"
@export var generate_spawners : bool = true
@export var generate_waypoints : bool = true

@export var water_height : float = 0.0

func ClearSurface(_val : bool) -> void:
    for child in get_children():
        child.queue_free()
    if generate_spawners:
        for spawner in spawner_tree.get_children():
            spawner.ExecuteClear(true)
    if generate_waypoints:
        waypoints.ExecuteClear(true)
        
    

func GenerateSurface(_val : bool) -> void:
    if !terrain:
        print("[NT MAPPER] Terrain is not set!")
    if !spawner_tree:
        print("[NT MAPPER] Spawner tree not set!")
    
    ClearSurface(true)
    print("gen")
    var mdt : MeshDataTool = MeshDataTool.new()
    mdt.create_from_surface(terrain.mesh, 0)
    var num_faces : int = mdt.get_face_count()
    var new_mesh_black : ArrayMesh = ArrayMesh.new()
    var new_mesh_red : ArrayMesh = ArrayMesh.new()
    var new_mesh_land : ArrayMesh = ArrayMesh.new()
    var arrays_black : Array
    arrays_black.resize(Mesh.ARRAY_MAX)
    var arrays_red : Array
    arrays_red.resize(Mesh.ARRAY_MAX)
    var arrays_land : Array
    arrays_land.resize(Mesh.ARRAY_MAX)
    var vertices_black = PackedVector3Array()
    var vertices_red = PackedVector3Array()
    var vertices_land = PackedVector3Array()
    
    for i in range(0,num_faces):
        var v0 : int = mdt.get_face_vertex(i,0)
        var v1 : int = mdt.get_face_vertex(i,1)
        var v2 : int = mdt.get_face_vertex(i,2)
        
        if mdt.get_vertex(v0).y > water_height && mdt.get_vertex(v1).y > water_height && mdt.get_vertex(v2).y > water_height:
            vertices_land.push_back(mdt.get_vertex(v0))
            vertices_land.push_back(mdt.get_vertex(v1))
            vertices_land.push_back(mdt.get_vertex(v2))
        
        if mdt.get_vertex_color(v0).r > 0 || mdt.get_vertex_color(v1).r > 0 || mdt.get_vertex_color(v2).r > 0:
            vertices_red.push_back(mdt.get_vertex(v0))
            vertices_red.push_back(mdt.get_vertex(v1))
            vertices_red.push_back(mdt.get_vertex(v2))
        else:
            vertices_black.push_back(mdt.get_vertex(v0))
            vertices_black.push_back(mdt.get_vertex(v1))
            vertices_black.push_back(mdt.get_vertex(v2))
    #print(arrays)
    
    arrays_black[Mesh.ARRAY_VERTEX] = vertices_black
    new_mesh_black.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays_black)
    
    arrays_red[Mesh.ARRAY_VERTEX] = vertices_red
    new_mesh_red.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays_red)
    
    arrays_land[Mesh.ARRAY_VERTEX] = vertices_land
    new_mesh_land.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays_land)
    
    var new_mesh3d_black = MeshInstance3D.new()
    var new_mesh3d_red = MeshInstance3D.new()
    var new_mesh3d_land = MeshInstance3D.new()
    new_mesh3d_black.mesh = new_mesh_black
    new_mesh3d_red.mesh = new_mesh_red
    new_mesh3d_land.mesh = new_mesh_land
    add_child(new_mesh3d_black, true)
    new_mesh3d_black.owner = get_tree().edited_scene_root
    new_mesh3d_black.create_trimesh_collision()
    new_mesh3d_black.visible = false
    new_mesh3d_black.name = "Mesh_Surface_Black"
    add_child(new_mesh3d_red, true)
    new_mesh3d_red.owner = get_tree().edited_scene_root
    new_mesh3d_red.create_trimesh_collision()
    new_mesh3d_red.visible = false
    new_mesh3d_red.name = "Mesh_Surface_Red"
    add_child(new_mesh3d_land, true)
    new_mesh3d_land.owner = get_tree().edited_scene_root
    #new_mesh3d_land.create_trimesh_collision()
    new_mesh3d_land.visible = false
    new_mesh3d_land.name = "Mesh_Surface_Land"
    
    if generate_spawners:
        for spawner in spawner_tree.get_children():
            spawner.surface = new_mesh_black
            spawner.ExecuteGenerate(true)
        
    if generate_waypoints:
        if waypoints:
            waypoints.terrain = new_mesh_land
            waypoints.ExecuteGenerate(true)
    
    var child = new_mesh3d_black.get_child(0)
    if child is StaticBody3D:
        child.set_script(Surface)
        var sur = child as Surface
        sur.surface = black_surface
    
    child = new_mesh3d_red.get_child(0)
    if child is StaticBody3D:
        child.set_script(Surface)
        var sur = child as Surface
        sur.surface = red_surface
    

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass
