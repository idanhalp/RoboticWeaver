function MoveXY( x,y )
%MoveXY Move the robot to given x,y coordinates and set the suction cup close to the table 
%------------Table Overhead look--------------
%(0,0)----------------y----------------(0,920)
%---------------------------------------------
%--x------------------------------------------
%---------------------------------------------
%---------------------------------------------
%(420,0)-----------------------------(420,920)

%z_high = -145;
%global Global_params
%z_high = Global_params('z_max');
z_high = 200;
speed = 5 ; %Global_params('speed')
% x,y transformation
x = 800 - x;
y = 400 - y;%shai 460 1302

Com_h = evalin('base','Com_h');
if (Com_h==0)
   if (x>800 || x<400) 
       error('X out of proper range');
   end
   if (y>460 || y<-460) 
       error('Y out of proper range');
   end
  % MoveZ(z_high);
% co shai1202   MoveX(x);
%co shai1202    MoveY(y);
  % pause(3);
   P = GetFullPos();
   MoveRobot(x,y,z_high,P(4),P(5),P(6),'ROBOT',speed);
%   co shai1202 HeadCorrection();

else
    disp('Communication is not initialized correctly. Please apply "Com_h = Init()" first until Com_h==0.');
end

end

