# Road to Vosok Map Template
A Template for creating custom maps for Road to Vostok. Includes a scene loader and injector (nt_SceneLoader) and tools for generating surface meshes for the instanced mesh generation system and for things like collisions and footstep sounds. It does not conflict with any other mods I've tried and custom maps created using this template should not collide with one another **as long as your map has a unique name, so don't make it something generic.**

# Guide
**Video Tutorial**

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/rsxqYZ7qZvw/0.jpg)](https://www.youtube.com/watch?v=rsxqYZ7qZvw)

**Pre-requisites:**
* Familiarity with Godot and basic 3D Modelling skills.
* A copy of Road to Vostok.
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
6. If you can enter and exit the map correctly you should be ready to start creating your map.

**Read through "MapTemplate/Main.gd" to get an idea of how registering your custom map with the loader works.**

**Shelters:**

Watch the "Shelters" segment of the Tutorial or:
1. Set the shelter constant to true in your MapTemplate/Main.gd.
2. Check "Shelter Enter" on your entrance Transition point and "Shelter Exit" on your exit Transition point.
3. In the "Map" node in your map, set Map Type to "Shelter" and under Details set Shelter Location to whatever map is *outside* of your shelter.

**Navmesh & AI:**

Regarding the navmesh I don't have a good solution currently. You could follow the guide in the video or look at one of the existing maps to get an idea of what the end result *should* look like but I highly recommend finding a better method. I will post an update when and if I do decide to tackle that.

**Exporting:**
1. Rename your MapTemplate folder to whatever you want your mod name to be and update the Main.gd file paths accordingly.
2. Configure your mod.txt, **set the MapTemplate autoload name to something unique.**
3. Export with ModZipExporter (make sure you are naming your zip file as .vmz, not .zip)
