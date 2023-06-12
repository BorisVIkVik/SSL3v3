PLXY = -1400;
PLYY = 0;
GX = -2000;
GY = 0;
if RP.Ball.I
    BX = -RP.Ball.x;
    BY = -RP.Ball.y;    
else
    BX = 3000;
    BY = 3000;
end

if(abs(BX) < 1050)
    PLXY = BY * abs(GX - PLXY) / abs(GX - BX);
else
    PLYY = -RP.Blue(robotIDP).y;
    PLXY = -RP.Blue(robotIDP).x;
end