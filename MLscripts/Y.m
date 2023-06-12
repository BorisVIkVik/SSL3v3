robotIDAY = 2;

robotIDY = 3;

global timerY
if isempty(timerY)
    timerY = cputime;
end

global timerAY
if isempty(timerAY)
    timerAY = cputime;
end


global timerKICKY
if isempty(timerKICKY)
    timerKICKY = cputime;
end


KeeperCoords;
rAngleA = RP.Blue(robotIDAY).ang;
XBA = RP.Blue(robotIDAY).x + BX;
YBA = RP.Blue(robotIDAY).y + BY; 
XBLA = XBA * cos(rAngleA) + YBA * sin(rAngleA);
YBLA = XBA * sin(rAngleA) - YBA * cos(rAngleA);
angleToBallA = atan2(-XBLA, YBLA);
angleToBallA = (3.14/2) - angleToBallA;

attacker;
disp(stateA);

XA = RP.Blue(robotIDAY).x - ROBOT_GO_X;
YA = RP.Blue(robotIDAY).y - ROBOT_GO_Y;
XAL = XA * cos(rAngleA) + YA*sin(rAngleA);
YAL = XA * sin(rAngleA) - YA*cos(rAngleA);

if angleToBallA < 4.6 && angleToBallA > 1.5 && stateA ~= 0
    stateA = 0;
end

if angleToBallA < 1.5 && stateA == 0
    stateA = 1;
end


XGBA = RP.Blue(robotIDAY).x + 1000;
YGBA = RP.Blue(robotIDAY).y - 0;
XGBLA = XGBA * cos(rAngleA) + YGBA * sin(rAngleA);
YGBLA = XGBA * sin(rAngleA) - YGBA * cos(rAngleA);
angleToGoalBA = atan2(-XGBLA, YGBLA);
angleToGoalBA = (3.14/2) - angleToGoalBA;



if angleToGoalBA > 3.14
    angleToGoalBA = angleToGoalBA - 6.28;
end

if angleToGoalBA < -3.14
    angleToGoalBA = angleToGoalBA + 6.28;
end

speedRA = min(abs(angleToGoalBA)*4, 15) * sign(angleToGoalBA);
%toAngleA = atan2(-XAL, YAL);
%toAngleA = (3.14/2) - toAngleA;

global IAXY
if isempty(IAXY)
    IAXY = 0;
end

global IAYY
if isempty(IAYY)
    IAYY = 0;
end

global XAL_OLDY
if isempty(XAL_OLDY)
    XAL_OLDY = 0;
end

global YAL_OLDY
if isempty(YAL_OLDY)
    YAL_OLDY = 0;
end




PAX = XAL * -0.1;
PAY = YAL * -0.2;
IAXY = IAXY - XAL * (cputime - timerAY) * 0.01;
IAYY = IAYY - YAL * (cputime - timerAY) * 0.01;
timerAY = cputime;

if abs(XA) < 10 
    IAXY = 0;
end

if abs(YA) < 10
   IAYY = 0; 
end

IAXY = sign(IAXY) * min(abs(IAXY), 8);
IAYY = sign(IAYY) * min(abs(IAYY), 5);

DAX = (XAL - XAL_OLDY) * -0;
DAY = (YAL - YAL_OLDY) * -0;

XAL_OLDY = XAL;
YAL_OLDY = YAL;

speedXA = PAX  + IAXY;
speedYA = PAY  + IAYY;
%disp(toAngle);

if ~RP.Blue(robotIDAY).I  
    speedXA = 0;
    speedYA = 0;
end

speedXA = sign(speedXA) * min(abs(speedXA)*1, 40);
speedYA = sign(speedYA) * min(abs(speedYA)*1, 40);   
if (sqrt(XA*XA + YA*YA) < 45) && stateA ~= 3
    stateA = stateA + 1;
    if stateA == 3
        timerKICKY = cputime;
    end
    
    if stateA >= 4
        stateA = 0;
    end
elseif stateA == 3 && cputime - timerKICKY > 0.7
    stateA = 0;    
end

RP.Blue(9).rul = Crul(speedXA,speedYA,kekUP,speedRA,0);
%RP.Blue(12).rul = Crul(speedXA,speedYA,kekUP,speedRA,0);
%RP.Blue(11).rul = Crul(0,0,0,5,0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rAngle = RP.Blue(robotIDY).ang;

X = RP.Blue(robotIDY).x + KX;
Y = RP.Blue(robotIDY).y + KY;
XL = X * cos(rAngle) + Y*sin(rAngle);
YL = X * sin(rAngle) - Y*cos(rAngle);

toAngle = atan2(-XL, YL);
toAngle = (3.14/2) - toAngle;





XKP = RP.Blue(robotIDY).x - 600;
YKP = RP.Blue(robotIDY).y - 800; 
XKPL = XKP * cos(rAngle) + YKP * sin(rAngle);
YKPL = XKP * sin(rAngle) - YKP * cos(rAngle);
angleToKP = atan2(-XKPL, YKPL);
angleToKP = (3.14/2) - angleToKP;




XGB = RP.Blue(robotIDY).x + 1255;
YGB = RP.Blue(robotIDY).y - 0;
XGBL = XGB * cos(rAngle) + YGB * sin(rAngle);
YGBL = XGB * sin(rAngle) - YGB * cos(rAngle);
angleToGoalB = atan2(-XGBL, YGBL);
angleToGoalB = (3.14/2) - angleToGoalB;




% XBL = XB * cos(rAngle) + YB * sin(rAngle);
% YBL = XB * sin(rAngle) - YB * cos(rAngle);
% angleToBall = atan2(-XBL, YBL);
% angleToBall = (3.14/2) - angleToBall;




global IXY
if isempty(IXY)
    IXY = 0;
end

global IYY
if isempty(IYY)
    IYY = 0;
end

global XL_OLDY
if isempty(XL_OLDY)
    XL_OLDY = 0;
end

global YL_OLDY
if isempty(YL_OLDY)
    YL_OLDY = 0;
end


PX = XL * -0.15;
PY = YL * -0.1;
IXY = IXY - XL * (cputime - timerY) * 0.001;
IYY = IYY - YL * (cputime - timerY) * 0.001;
timerY = cputime;

if abs(X) < 10 
    IXY = 0;
end

if abs(Y) < 10
   IYY = 0; 
end

IXY = sign(IXY) * min(abs(IXY), 8);
IYY = sign(IYY) * min(abs(IYY), 5);

DX = (XL - XL_OLDY) * -0;
DY = (YL - YL_OLDY) * -0;

XL_OLDY = XL;
YL_OLDY = YL;

speedX = PX  + IXY + DX;
speedY = PY  + IYY + DY;
%disp(toAngle);
if abs(X) < 30 && abs(Y) < 30
    speedX = 0;
    speedY = 0;
end

if ~RP.Blue(robotIDY).I  
    speedX = 0;
    speedY = 0;
end

% 
% if angleToBall > 3.14
%     angleToBall = angleToBall - 6.28;
% end
% 
% if angleToBall < -3.14
%     angleToBall = angleToBall + 6.28;
% end


if angleToKP > 3.14
    angleToKP = angleToKP - 6.28;
end

if angleToKP < -3.14
    angleToKP = angleToKP + 6.28;
end

speedR = min(abs(angleToKP)*4, 15) * sign(angleToKP);
%disp(IXY)
speedX = sign(speedX) * min(abs(speedX)*3, 40);
speedY = sign(speedY) * min(abs(speedY)*3, 40);    
RP.Blue(12).rul = Crul(speedX,speedY,0,speedR,0);
%RP.Blue(10).rul = Crul(0,0,0,5,0);
disp([speedX, speedY]);

%RP.Blue(9).rul = Crul(speedX,speedY,0,speedR,0);
