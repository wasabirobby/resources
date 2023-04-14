local blips = {
    {title="Diamond Casino", colour=26, id=143, x = 2155.42, y = 2155.2, z = 9.6626},
    {title="Gouvernement de San Andreas", colour=141, id=143, x = 2615.66, y = 1208.6, z = 9.82031},
    {title="Station Essence", colour=26, id=143, x = 2149.95, y = 2743.54, z = 15.1465},
    {title="Station Essence", colour=26, id=143, x = -2410.9016, y = 973.3707, z = 45.4611},
    {title="Station Essence", colour=26, id=143, x = -1676.4094, y = 411.4249, z = 7.1855},
    {title="Station Essence", colour=26, id=143, x = 1938.3774, y = -1774.929, z = 13.3807},
    {title="Station Essence", colour=26, id=143, x = 991.3203, y = -923.0583, z = 42.1756},
    {title="Station Essence", colour=26, id=143, x = 960.5027, y = 2373.9399, z = 10.8118},
    {title="Station Essence", colour=26, id=143, x = 655.5325, y = -565.2853, z = 16.359},
    {title="Station Essence", colour=26, id=143, x = -1606.66, y = -2713.6404, z = 48.5426},
    {title="Station Essence", colour=26, id=143, x = -2244.3582, y = -2561.228, z = 31.925},
    {title="Station Essence", colour=26, id=143, x = -91.3892, y = -1168.713, z = 2.4582},
    {title="Station Essence", colour=26, id=143, x = 76.7323, y = -251.0259, z = 1.5826},
    {title="Station Essence", colour=26, id=143, x = 70.8781, y = 1219.3182, z = 18.8116},
    {title="Station Essence", colour=26, id=143, x = -1329.1594, y = 2677.7661, z = 50.0517},
    {title="Rockford Records", colour=26, id=143, x = 2116.5608, y = 920.0358, z = 10.8146},
    {title="Rockford Records", colour=26, id=143, x = 983.955, y = 2409.73, z = 11.941},
    {title="Bungalows & Night Club", colour=26, id=143, x = -3119.6382, y = 465.4735, z = 6.0801},
    {title="Bungalows & Night Club", colour=26, id=143, x = 621.3885, y = -2423.8186, z = 11.3314},
    {title="Ecole", colour=26, id=143, x = 711.7839, y = -1272.6826, z = 15.2707},
    {title="Diner", colour=26, id=143, x = 92.5495, y = 1165.6598, z = 19.3458},
    {title="Weazel News", colour=26, id=143, x = 1090.8, y = 1786.98, z = 9.81396},
    {title="Sushi", colour=5, id=143, x = -2171.7371, y = 132.637, z = 35.3194},
    {title="Restaurant", colour=5, id=143, x = 2495.14, y = 1286.52, z = 15.8845},
    {title="Maisonette 10", colour=61, id=143, x = 2803.13, y = 2259.22, z = 10.7663},
    {title="Beach Club", colour=61, id=143, x = 829.133, y = -2243.87, z = 19.8807},
    {title="Alhambra", colour=61, id=143, x = 1839.55, y = -1681.16, z = 28.1201},
    {title="Minigolf", colour=61, id=143, x = 95.6688, y = -1872.4377, z = 3.7255},
    {title="UwU Cat Café", colour=61, id=143, x = -1528.3726, y = 1033.1451, z = 7.2119},
    {title="Sherrif Paleto Bay", colour=61, id=143, x = -1459.1068, y = 2644.8435, z = 56.6367},
    {title="Benny's Auto & Tuning", colour=26, id=143, x = 1875.26, y = -1766.56, z = 24.3577},
    {title="Beachside Fitness", colour=26, id=143, x = 657.103, y = -1873.53, z = 4.46143},
    {title="Nightclub", colour=61, id=143, x = 1314.26, y = -1164.45, z = 35.6311},
    {title="Centre Commercial", colour=26, id=143, x = -1049.62, y = -998.38, z = 152.696},
    {title="Restaurant Italien", colour=5, id=143, x = 1498.2477, y = -1573.5251, z = 13.5515},
    {title="Caserne de pompier", colour=1, id=143, x = 1745.5455, y = -1465.769, z = 13.5988},
    {title="Hopital", colour=2, id=61, x = 1658.6, y = -1399.19, z = 12.5681},
    {title="Apple Store", colour=0, id=143, x = 1764.84, y = -1342.19, z = 18.6331},
    {title="Appartement", colour=0, id=40, x = 1565.94, y = -1342.04, z = 233.071},
    {title="Epicerie", colour=26, id=143, x = 253.703, y = -57.5952, z = 4.88342},
    {title="Popeyes", colour=5, id=143, x = 1398.557, y = -1681.3822, z = 13.5519},
    {title="Amazon Café", colour=5, id=143, x = 387.3851, y = -1923.5536, z = 7.9254},
    {title="Dunkin", colour=5, id=143, x = 1038.2145, y = -1343.7245, z = 13.7298},
    {title="McDonald's", colour=5, id=143, x = 2390.8042, y = -1909.1346, z = 13.6914},
    {title="Burgershot", colour=5, id=143, x = 794.1665, y = -1619.1996, z = 12.7114},
    {title="Burgershot", colour=5, id=143, x = 1195.4576, y = -903.7592, z = 42.4614},
    {title="Housing", colour=0, id=40, x = 1299.13, y = -1275.75, z = 12.5522},
    {title="Chalet", colour=0, id=40, x = 414.428, y = -982.559, z = 98.1194},
    {title="Villa", colour=0, id=40, x = 2989.81, y = -1334.68, z = 20},
    {title="Club de Biker", colour=26, id=143, x = 2264.67, y = -2048.89, z = 12.5505},
    {title="Icebox", colour=26, id=143, x = 2620.9041, y = -1382.8893, z = 30.4317},
    {title="Crypto.com Arena", colour=26, id=143, x = 2731.4863, y = -1735.484, z = 15.6238},
    {title="Cookies Store", colour=2, id=143, x = -239.875, y = 2605.31, z = 69.1902},
    {title="Gym", colour=26, id=143, x = 2224.12, y = -1727.22, z = 20},
    {title="Villa", colour=0, id=40, x = 2142.84, y = -95.0327, z = 1.79126},
    {title="Gonzalez Auto", colour=26, id=143, x = 87.8794, y = 1074.47, z = 16.9603},
    {title="SSPD", colour=26, id=143, x = 622.37, y = -570.5, z = 25.1282},
    {title="Motel", colour=26, id=143, x = 2216.51, y = -1172.46, z = 24.7194},
    {title="Hopital", colour=2, id=61, x = 2033.0765, y = -1388.9668, z = 17.2546},
    {title="Hopital", colour=2, id=61, x = -2655.9878, y = 652.2292, z = 14.434},
    {title="LSPD", colour=26, id=137, x = 1565.1566, y = -1675.3942, z = 17.1411},
    {title="LS Vespucci", colour=26, id=137, x = 1721.0844, y = -1770.3674, z = 13.8685},
    {title="LVPD", colour=26, id=137, x = 2825.0144, y = 887.4069, z = 13.1424},
    {title="Tribunal", colour=26, id=137, x = 1480.3475, y = -1784.1353, z = 17.713},
    {title="Retour Vehicule", colour=26, id=137, x = 1648.3152, y = -1136.3323, z = 24.0},
    {title="Retour Vehicule", colour=26, id=137, x = -2501.2559, y = 410.887, z = 27.6107},
    {title="Retour Vehicule", colour=26, id=137, x = 1971.4762, y = 2250.2732, z = 14.3361},
    {title="Animalerie", colour=26, id=137, x = -2438.7061, y = 21.7034, z = 35.2329},
 }
      
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.6)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)