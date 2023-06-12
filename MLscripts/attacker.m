global stateA
if isempty(stateA)
   stateA = 0; 
end

if RP.Ball.I
    XBallGoal = 2000 - RP.Ball.x;
    YBallGoal = 0 - RP.Ball.y;
    koef = sqrt(90000/(XBallGoal * XBallGoal + YBallGoal * YBallGoal));
    koef1 = sqrt(3000/(XBallGoal * XBallGoal + YBallGoal * YBallGoal));
    kekUP = 0;
    if stateA == 0   
       disp(angleToBallA);
       if angleToBallA < 3.14
         XToBall = YBallGoal * koef;
         YToBall = -XBallGoal * koef;
       else
         %disp('clown');
         XToBall = -YBallGoal * koef;
         YToBall = XBallGoal * koef;
       end
    elseif stateA == 1
       XToBall = -XBallGoal * koef;
       YToBall = -YBallGoal * koef;
    elseif stateA == 2
        XToBall = -XBallGoal * koef1;
        YToBall = -YBallGoal * koef1;
    elseif stateA == 3
        XToBall = -XBallGoal * koef1;
        YToBall = -YBallGoal * koef1;
        kekUP = 1;
    end
    ROBOT_GO_X = XToBall + RP.Ball.x;
    ROBOT_GO_Y = YToBall + RP.Ball.y;
else
    ROBOT_GO_X = 0;
    ROBOT_GO_Y = 0;
end