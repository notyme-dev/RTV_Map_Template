# Road to Vosok Map Template
A Template for creating custom maps for Road to Vostok. Includes a custom scene loader and injector (nt_SceneLoader) and tools for generating surface meshes for the instanced mesh generation system and for things like collisions and footstep sounds. 

# Guide
**Pre-requisites:**
* A copy of Road to Vostok
* GDRE: https://github.com/GDRETools/gdsdecomp
* Godot (download whatever version GDRE tells you to, right now it's 4.6.1 but that might change)
* 3D Modelling software for terrain creation (for example Blender)
* ModZipExporter (Godot Addon): https://github.com/Ryhon0/ModZipExporter/

**Set-up:**
1. Download the above mentioned pre-requisites.
2. Decompile Road to Vostok using GDRE, this will generate your project folder.
3. Downlaod the ModTemplate.zip from "releases" on this pages and extract the contents into your RTV Godot project folder.
4. To run and debug your mod inside of Godot, add "MapTemplate/nt_SceneLoader/nt_Loader.gd", "MapTemplate/nt_SceneLoader/Main.gd" and "MapTemplate/Main.gd" to your Autoloads in the project settings.
5. Run the game from Godot to check if everything is set up correctly (the entrance to the map is located outside of the Cabin). **(MAKE SURE TO BACKUP YOUR SAVE FILES BEFORE DOING ANY MODDING)**
6. If you can enter and exit the map correctly with no errors showing up in the Godot output you should be ready to start creating your map.

**Read through "MapTemplate/Main.gd" to get an idea of how registering your custom map with the loader works.**
