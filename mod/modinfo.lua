-- This File contains all the properties and configuration options of this mod. For the implementation,
-- see modmain.lua

-- Mod Info
name = "Zoom++"
description = "Configure the camera how you like it!"
author = "Conrad"
version = "1.0.1"
all_clients_require_mod = false
client_only_mod = true
api_version = 10

-- Mod Icon
icon_atlas = "modicon.xml"
icon = "modicon.tex"
-- BTW if you find yourself here trying to find out how to make your own modIcon, use the
-- TEXCreator.exe from https://github.com/handsomematt/dont-starve-tools/releases

-- Mod Compatibility, tbh I didn't check but I doubt it
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
hamlet_compatible = false
dst_compatible = true

-- Configuration Options
configuration_options = {
    { -- This creates a header within the configuration menu
        name = "zoom",
        label = "Zoom",
        hover = "Configure Zoom",
        options = { { description = "", data = false } },
        default = false
    },
    {
        name = "minCameraDistance",
        label = "Min Camera Distance",
        hover = "Change How far the camera can zoom in",
        options = {
            {
                description = 0,
                data = 0
            },
            {
                description = 5,
                data = 5
            },
            {
                description = 10,
                data = 10
            },
            {
                description = "15 (DST Default)",
                data = 15
            },
            {
                description = 20,
                data = 20
            },
            {
                description = 25,
                data = 25
            },
            {
                description = 30,
                data = 35
            },
            {
                description = 40,
                data = 40
            },
            {
                description = 45,
                data = 45
            },
            {
                description = 50,
                data = 50
            },
        },
        default = 15;
    },
    {
        name = "maxCameraDistance",
        label = "Max Camera Distance",
        hover = "Change How far the camera can zoom out",
        options = {
            {
                description = "50 (DST Default)",
                data = 50
            },
            {
                description = 60,
                data = 60
            },
            {
                description = 70,
                data = 70
            },
            {
                description = 80,
                data = 80
            },
            {
                description = 90,
                data = 90
            },
            {
                description = 100,
                data = 100
            },
            {
                description = 110,
                data = 110
            },
            {
                description = 120,
                data = 120
            },
            {
                description = 130,
                data = 130
            },
            {
                description = 140,
                data = 140
            },
            {
                description = 150,
                data = 150
            },
            {
                description = 160,
                data = 160
            },
        },
        default = 120
    },
    {
        name = "zoomStep",
        label = "Zoom Step",
        hover = "Change how fast the camera zooms.",
        options = {
            {
                description = 1,
                data = 1
            },
            {
                description = 2,
                data = 2
            },
            {
                description = 3,
                data = 3
            },
            {
                description = "4 (DST Default)",
                data = 4
            },
            {
                description = 5,
                data = 5
            },
            {
                description = 6,
                data = 6
            },
            {
                description = 7,
                data = 7
            },
            {
                description = 8,
                data = 8
            },
            {
                description = 9,
                data = 9
            },
            {
                description = 10,
                data = 10
            },
        },
        default = 4;
    },
    {  -- This creates a header within the configuration menu
        name = "cameraAngle",
        label = "Camera Angle",
        hover = "Configure Camera Angle",
        options = { { description = "", data = false } },
        default = false
    },
    {
        name = "minDistancePitch",
        label = "Min Distance Pitch",
        hover = "Change the angle of the camera when zoomed all the way in",
        options = {
            {
                description = "0°",
                data = 0
            },
            {
                description = "5°",
                data = 5
            },
            {
                description = "10°",
                data = 10
            },
            {
                description = "15°",
                data = 15
            },
            {
                description = "20°",
                data = 20
            },
            {
                description = "25°",
                data = 25
            },
            {
                description = "30° (DST Default)",
                data = 30
            },
            {
                description = "35°",
                data = 35
            },
            {
                description = "45°",
                data = 45
            },
            {
                description = "50°",
                data = 50
            },
            {
                description = "55°",
                data = 55
            },
            {
                description = "60°",
                data = 60
            },
            {
                description = "65°",
                data = 65
            },
            {
                description = "70°",
                data = 70
            },
            {
                description = "75°",
                data = 75
            },
            {
                description = "80°",
                data = 80
            },
            {
                description = "85°",
                data = 85
            },
            {
                description = "90°",
                data = 90
            },
        },
        default = 30
    },
    {
        name = "maxDistancePitch",
        label = "Max Distance Pitch",
        hover = "Change the angle of the camera when zoomed all the way out",
        options = {
            {
                description = "0°",
                data = 0
            },
            {
                description = "5°",
                data = 5
            },
            {
                description = "10°",
                data = 10
            },
            {
                description = "15°",
                data = 15
            },
            {
                description = "20°",
                data = 20
            },
            {
                description = "25°",
                data = 25
            },
            {
                description = "30°",
                data = 30
            },
            {
                description = "35°",
                data = 35
            },
            {
                description = "45°",
                data = 45
            },
            {
                description = "50°",
                data = 50
            },
            {
                description = "55°",
                data = 55
            },
            {
                description = "60° (DST Default)",
                data = 60
            },
            {
                description = "65°",
                data = 65
            },
            {
                description = "70°",
                data = 70
            },
            {
                description = "75°",
                data = 75
            },
            {
                description = "80°",
                data = 80
            },
            {
                description = "85°",
                data = 85
            },
            {
                description = "90°",
                data = 90
            },
        },
        default = 60
    },
    {-- This creates a header within the configuration menu
        name = "extras",
        label = "Extras",
        hover = "Extra Features",
        options = { { description = "", data = false } },
        default = false
    },
    {
        name = "clouds",
        label = "Clouds",
        hover = "Enable or disable clouds that appear when zoomed out",
        options = {
            {
                description = "Enabled",
                data = "Enabled"
            },
            {
                description = "Disabled",
                data = "Disabled"
            },

        },
        default = "Disabled"
    },
    {
        name = "knobblyTreeLeaves",
        label = "Knobbly Tree Leaves",
        hover = "Enable or disable the Knobbly Tree Leaves",
        options = {
            {
                description = "Enabled",
                data = "Enabled"
            },
            {
                description = "Disabled",
                data = "Disabled"
            },

        },
        default = "Enabled"
    },
    {
        name = "fov",
        label = "FOV (EXPERIMENTAL)",
        hover = "Change the camera's field of view.\nIt's not recommended to change this.",
        options = {
            {
                description = 5,
                data = 5
            },
            {
                description = 10,
                data = 10
            },
            {
                description = 15,
                data = 15
            },
            {
                description = 20,
                data = 20
            },
            {
                description = 25,
                data = 25
            },
            {
                description = 30,
                data = 30
            },
            {
                description = "35 (DST Default)",
                data = 35
            },
            {
                description = 40,
                data = 40
            },
            {
                description = 45,
                data = 45
            },
            {
                description = 50,
                data = 50
            },
            {
                description = 55,
                data = 55
            },
            {
                description = 60,
                data = 60
            },
            {
                description = 65,
                data = 65
            },
            {
                description = 70,
                data = 75
            },
            {
                description = 80,
                data = 80
            },
            {
                description = 80,
                data = 80
            },
            {
                description = 85,
                data = 85
            },
            {
                description = 90,
                data = 90
            },
        },
        default = 35;
    },
}

