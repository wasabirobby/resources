Config = {}
Config.Interior = vector3(1748.82, -1858.24, -15.36) -- Interior to load where characters are previewed
Config.DefaultSpawn = vector3(1748.82, -1858.24, -15.36) -- Default spawn coords if you have start apartments disabled
Config.PedCoords = vector4(1749.92, -1859.28, -45.2, 54.37)  -- Create preview ped at these coordinates
Config.HiddenCoords = vector4(1749.38, -1856.2, -45.36, 64.02) -- Hides your actual ped while you are in selection
Config.CamCoords = vector4(1590.97, -1767.25, 73.85, 48.51)-- Camera coordinates for character preview screen
--Config.CamCoords = vector4(1747.64, -1857.59, -45.36, 229.18) 
Config.EnableDeleteButton = true -- Define if the player can delete the character or not
Config.customNationality = false -- Defines if Nationality input is custom of blocked to the list of Countries

Config.DefaultNumberOfCharacters = 5 -- Define maximum amount of default characters (maximum 5 characters defined by default)
Config.PlayersNumberOfCharacters = { -- Define maximum amount of player characters by rockstar license (you can find this license in your server's database in the player table)
    { license = "license:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", numberOfChars = 2 },
}