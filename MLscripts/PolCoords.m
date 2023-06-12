PLX = 1400;
PLY = 0;
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
    PLX = BY * abs(GX - PLX) / abs(GX - BX);
else
    PLY = -RP.Blue(robotIDP).y;
    PLX = -RP.Blue(robotIDP).x;
end