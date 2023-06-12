KX = 1800;
GX = 2000;
GY = 0;
if RP.Ball.I
    BX = -RP.Ball.x;
    BY = -RP.Ball.y;    
else
    BX = 3000;
    BY = 3000;
end

if(abs(BX) < 1050)
    KY = BY * abs(GX - KX) / abs(GX - BX);
else
    KY = -RP.Blue(robotID).y;
    KX = -RP.Blue(robotID).x;
end