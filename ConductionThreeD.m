emagmodel = createpde("electromagnetic","conduction");
gm = importGeometry(emagmodel,"PlateHoleSolid.stl");
pdegplot(gm,"FaceLabels","on","FaceAlpha",0.3)
electromagneticProperties(emagmodel,"Conductivity",6e4);
electromagneticBC(emagmodel,"Voltage",0,"Face",3:6);
electromagneticBC(emagmodel,"SurfaceCurrentDensity",100,"Face",7);
generateMesh(emagmodel);
R = solve(emagmodel)

figure
pdeplot3D(emagmodel,"ColorMapData",R.ElectricPotential)
title("Electric Potential")

figure
pdeplot3D(emagmodel,"ColorMapData",R.CurrentDensity.Jx)
title("x-Component of Current Density")

figure
pdeplot3D(emagmodel,"ColorMapData",R.CurrentDensity.Jy)
title("y-Component of Current Density")

figure
pdeplot3D(emagmodel,"ColorMapData",R.CurrentDensity.Jz)
title("z-Component of Current Density")

