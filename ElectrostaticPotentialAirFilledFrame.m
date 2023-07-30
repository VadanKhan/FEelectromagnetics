emagmodel = createpde("electromagnetic","electrostatic");
importGeometry(emagmodel,"Frame.STL");
pdegplot(emagmodel,"EdgeLabels","on")
emagmodel.VacuumPermittivity = 8.8541878128E-12;
electromagneticProperties(emagmodel,"RelativePermittivity",1.00059);
electromagneticBC(emagmodel,"Voltage",1000,"Edge",[1 2 4 6]);
electromagneticBC(emagmodel,"Voltage",0,"Edge",[3 5 7 8]);
generateMesh(emagmodel);
R = solve(emagmodel); 
u = R.ElectricPotential;
pdeplot(emagmodel,"XYData",u,"Contour","on")


