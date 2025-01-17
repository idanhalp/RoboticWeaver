function MoveXY_for_SnapShot( x,y )
%MoveXY Move the robot to given x,y coordinates and set the suction cup close to the table 
%------------Table Overhead look--------------
%(0,0)----------------y----------------(0,920)
%---------------------------------------------
%--x------------------------------------------
%---------------------------------------------
%---------------------------------------------
%(420,0)-----------------------------(420,920)

z_high = -145;

% x,y transformation
x = 800 - x;
y = 460 - y;

Com_h = evalin('base','Com_h');
if (Com_h==0)
   if (x>800 || x<400) 
       error('X out of proper range');
   end
   if (y>460 || y<-460) 
       error('Y out of proper range');
   end
   MoveZ(z_high);
   MoveX(x);
   MoveY_Snapshot(y);
   pause(0.3);
   P = GetFullPos();
   MoveRobot(x,y,-155,-87,44,-98,'ROBOT',5);

else
    disp('Communication is not initialized correctly. Please apply "Com_h = Init()" first until Com_h==0.');
end

end

