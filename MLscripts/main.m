%% MAIN START HEADER

global Blues Yellows Balls Rules FieldInfo RefState RefCommandForTeam RefPartOfFieldLeft RP PAR Modul activeAlgorithm obstacles gameStatus scenario
global timerStatus t ballSeenFlag stopFlag countBalls findAllRobotsFlag n sequenceLen points passCount passStatus

if isempty(RP)
    addpath tools RPtools MODUL
end

%

mainHeader();
%MAP();

if (RP.Pause) 
    return;
end

zMain_End=RP.zMain_End;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%PAR.HALF_FIELD=-1;
%PAR.MAP_X=4000;
%PAR.MAP_Y=3000;
%PAR.RobotSize=200;
%PAR.KICK_DIST=200;
%PAR.DELAY=0.15;
%PAR.WhellR=5;
%PAR.LGate.X=-2000;
%PAR.RGate.X=2000;
%PAR.BorotArm=225;

%% CONTRIL BLOCK

robotIDA = 3;

robotID = 8;

robotIDUP = 8;
robotIDAUP = 8;

global timer
if isempty(timer)
    timer = cputime;
end

global timerA
if isempty(timerA)
    timerA = cputime;
end


global timerKICK
if isempty(timerKICK)
    timerKICK = cputime;
end


KeeperCoords;
rAngleA = RP.Blue(robotIDA).ang;
XBA = RP.Blue(robotIDA).x + BX;
YBA = RP.Blue(robotIDA).y + BY; 
XBLA = XBA * cos(rAngleA) + YBA * sin(rAngleA);
YBLA = XBA * sin(rAngleA) - YBA * cos(rAngleA);
angleToBallA = atan2(-XBLA, YBLA);
angleToBallA = (3.14/2) - angleToBallA;

attacker;
disp(stateA);

XA = RP.Blue(robotIDA).x - ROBOT_GO_X;
YA = RP.Blue(robotIDA).y - ROBOT_GO_Y;
XAL = XA * cos(rAngleA) + YA*sin(rAngleA);
YAL = XA * sin(rAngleA) - YA*cos(rAngleA);

if angleToBallA < 4.6 && angleToBallA > 1.5 && stateA ~= 0
    stateA = 0;
end

if angleToBallA < 1.5 && stateA == 0
    stateA = 1;
end


XGBA = RP.Blue(robotIDA).x - 2000;
YGBA = RP.Blue(robotIDA).y - 0;
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

speedRA = min(abs(angleToGoalBA)*5, 20) * sign(angleToGoalBA);
%toAngleA = atan2(-XAL, YAL);
%toAngleA = (3.14/2) - toAngleA;

global IAX
if isempty(IAX)
    IAX = 0;
end

global IAY
if isempty(IAY)
    IAY = 0;
end

global XAL_OLD
if isempty(XAL_OLD)
    XAL_OLD = 0;
end

global YAL_OLD
if isempty(YAL_OLD)
    YAL_OLD = 0;
end




PAX = XAL * -0.1;
PAY = YAL * -0.2;
IAX = IAX - XAL * (cputime - timerA) * 0.01;
IAY = IAY - YAL * (cputime - timerA) * 0.01;
timerA = cputime;

if abs(XA) < 10 
    IAX = 0;
end

if abs(YA) < 10
   IAY = 0; 
end

IAX = sign(IAX) * min(abs(IAX), 16);
IAY = sign(IAY) * min(abs(IAY), 10);

DAX = (XAL - XAL_OLD) * -0;
DAY = (YAL - YAL_OLD) * -0;

XAL_OLD = XAL;
YAL_OLD = YAL;

speedXA = PAX  + IAX;
speedYA = PAY  + IAY;
%disp(toAngle);

if ~RP.Blue(robotIDA).I  
    speedXA = 0;
    speedYA = 0;
end

speedXA = sign(speedXA) * min(abs(speedXA)*1.2, 40);
speedYA = sign(speedYA) * min(abs(speedYA)*1.2, 40);   
if (sqrt(XA*XA + YA*YA) < 45) && stateA ~= 3
    stateA = stateA + 1;
    if stateA == 3
        timerKICK = cputime;
    end
    
    if stateA >= 4
        stateA = 0;
    end
elseif stateA == 3 && cputime - timerKICK > 0.4
    stateA = 0;    
    kekUP = 1;
end

RP.Blue(robotIDAUP).rul = Crul(speedXA * 0.8,speedYA * 0.8,0,speedRA * 2, 0, 2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rAngle = RP.Blue(robotID).ang;

X = RP.Blue(robotID).x + KX;
Y = RP.Blue(robotID).y + KY;
XL = X * cos(rAngle) + Y*sin(rAngle);
YL = X * sin(rAngle) - Y*cos(rAngle);

toAngle = atan2(-XL, YL);
toAngle = (3.14/2) - toAngle;





XKP = RP.Blue(robotID).x + 1350;
YKP = RP.Blue(robotID).y - 1800; 
XKPL = XKP * cos(rAngle) + YKP * sin(rAngle);
YKPL = XKP * sin(rAngle) - YKP * cos(rAngle);
angleToKP = atan2(-XKPL, YKPL);
angleToKP = (3.14/2) - angleToKP;




XGB = RP.Blue(robotID).x - 2100;
YGB = RP.Blue(robotID).y - 0;
XGBL = XGB * cos(rAngle) + YGB * sin(rAngle);
YGBL = XGB * sin(rAngle) - YGB * cos(rAngle);
angleToGoalB = atan2(-XGBL, YGBL);
angleToGoalB = (3.14/2) - angleToGoalB;




% XBL = XB * cos(rAngle) + YB * sin(rAngle);
% YBL = XB * sin(rAngle) - YB * cos(rAngle);
% angleToBall = atan2(-XBL, YBL);
% angleToBall = (3.14/2) - angleToBall;




global IX
if isempty(IX)
    IX = 0;
end

global IY
if isempty(IY)
    IY = 0;
end

global XL_OLD
if isempty(XL_OLD)
    XL_OLD = 0;
end

global YL_OLD
if isempty(YL_OLD)
    YL_OLD = 0;
end


PX = XL * -0.15;
PY = YL * -0.1;
IX = IX - XL * (cputime - timer) * 0.001;
IY = IY - YL * (cputime - timer) * 0.001;
timer = cputime;

if abs(X) < 10 
    IX = 0;
end

if abs(Y) < 10
   IY = 0; 
end

IX = sign(IX) * min(abs(IX), 8);
IY = sign(IY) * min(abs(IY), 5);

DX = (XL - XL_OLD) * -0;
DY = (YL - YL_OLD) * -0;

XL_OLD = XL;
YL_OLD = YL;

speedX = PX  + IX + DX;
speedY = PY  + IY + DY;
%disp(toAngle);
if abs(X) < 30 && abs(Y) < 30
    speedX = 0;
    speedY = 0;
end

if ~RP.Blue(robotID).I  
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
%disp(IX)
speedX = sign(speedX) * min(abs(speedX)*3, 40);
speedY = sign(speedY) * min(abs(speedY)*3, 40);    
RP.Blue(robotIDUP).rul = Crul(speedX * 0.5,speedY * 0.5,0,speedR,0);
disp([speedX, speedY]);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
kekUP = 0;
robotIDAY = 2;

robotIDY = 6;

robotIDYUP = 15;
robotIDAYUP = 15;

attCY;
KeY;

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


rAngleA = RP.Blue(robotIDAY).ang;
XBA = RP.Blue(robotIDAY).x + BX;
YBA = RP.Blue(robotIDAY).y + BY; 
XBLA = XBA * cos(rAngleA) + YBA * sin(rAngleA);
YBLA = XBA * sin(rAngleA) - YBA * cos(rAngleA);
angleToBallA = atan2(-XBLA, YBLA);
angleToBallA = (3.14/2) - angleToBallA;

XA = RP.Blue(robotIDAY).x - ROBOT_GO_X;
YA = RP.Blue(robotIDAY).y - ROBOT_GO_Y;
XAL = XA * cos(rAngleA) + YA*sin(rAngleA);
YAL = XA * sin(rAngleA) - YA*cos(rAngleA);

if angleToBallA < 4.6 && angleToBallA > 1.5 && stateAY ~= 0
    stateAY = 0;
end

if angleToBallA < 1.5 && stateAY == 0
    stateAY = 1;
end


XGBA = RP.Blue(robotIDAY).x + 2000;
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
if (sqrt(XA*XA + YA*YA) < 45) && stateAY ~= 3
    stateAY = stateAY + 1;
    if stateAY == 3
        timerKICKY = cputime;
    end
    
    if stateAY >= 4
        stateAY = 0;
    end
elseif stateAY== 3 && cputime - timerKICKY > 0.6
    stateAY = 0;    
end

RP.Blue(robotIDAYUP).rul = Crul(speedXA * 0.5,speedYA * 0.5,0,speedRA, 0, 2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rAngle = RP.Blue(robotIDY).ang;

disp(KX)
X = RP.Blue(robotIDY).x + KX;
Y = RP.Blue(robotIDY).y + KY;
XL = X * cos(rAngle) + Y*sin(rAngle);
YL = X * sin(rAngle) - Y*cos(rAngle);

toAngle = atan2(-XL, YL);
toAngle = (3.14/2) - toAngle;





XKP = RP.Blue(robotIDY).x - 1350;
YKP = RP.Blue(robotIDY).y - 1800; 
XKPL = XKP * cos(rAngle) + YKP * sin(rAngle);
YKPL = XKP * sin(rAngle) - YKP * cos(rAngle);
angleToKP = atan2(-XKPL, YKPL);
angleToKP = (3.14/2) - angleToKP;




XGB = RP.Blue(robotIDY).x + 2100;
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
RP.Blue(robotIDYUP).rul = Crul(speedX * 0.5,speedY * 0.5,0,speedR,0);
disp([speedX, speedY]);


%% END CONTRIL BLOCK

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% MAIN END

%Rules

zMain_End = mainEnd();