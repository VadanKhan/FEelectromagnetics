% 1. First run the below pde shapes to start creating the geometry
% 2. Then in the PDE Modeler App, a seperate window that opens, edit the
%       the set formula field to have (C1+C2+C3+C4+C5+R1+R2)*SQ1
% 3. select "draw" at the top and then "Export Geometry Description, Set 
%       Formula, Labels..."
% 4. Now comment out the pde shapes and run the rest of the code.



% pdecirc(0,0,1,'C1'); 
% pdecirc(0,0,0.8,'C2'); 
% pdecirc(0,0,0.6,'C3');
% pdecirc(0,0,0.5,'C4'); 
% pdecirc(0,0,0.4,'C5'); 
% pderect([-0.2 0.2 0.2 0.9],'R1'); 
% pderect([-0.1 0.1 0.2 0.9],'R2');
% pderect([0 1 0 1],'SQ1');

[d1,bt1] = decsg(gd,sf,ns);
pdegplot(d1,"EdgeLabels","on","FaceLabels","on")

[d2,bt2] = csgdel(d1,bt1,[1 3 8 25 7 2 12 26 30 33 4 9 34 10 31]);
pdegplot(d2,"EdgeLabels","on","FaceLabels","on")
emagmodel = createpde("electromagnetic","magnetostatic");
geometryFromEdges(emagmodel,d2);
emagmodel.VacuumPermeability = 1.2566370614E-6;
electromagneticProperties(emagmodel,"RelativePermeability",1, ...
                                    "Face",[3 4]);
electromagneticProperties(emagmodel,"RelativePermeability",5000, ...
                                    "Face",[1 2]);
electromagneticSource(emagmodel,"CurrentDensity",10,"Face",4);
electromagneticBC(emagmodel,"MagneticPotential",0,...
                 "Edge",[16 9 10 11 12 13 14 15]);
generateMesh(emagmodel);
R = solve(emagmodel);
figure
pdeplot(emagmodel,"XYData",R.MagneticPotential, ...
                  "FlowData",[R.MagneticField.Hx, ...
                              R.MagneticField.Hy], ...
                  "Contour","on", ...
                  "FaceAlpha",0.5)
title("Magnetic Potential and Field")


