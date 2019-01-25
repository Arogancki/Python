function [sys,x0] = ship_anim(t,x,u,flag,ts)

global shipcontrol

if flag==2,
	if any(get(0,'Children')==shipcontrol),
		if strcmp(get(shipcontrol,'Name'),'Ship control'),

			% Update
			hlist = get(shipcontrol,'UserData');

			shipXdata = [-120 80 80 -120; 80 130 130 80]';
			shipYdata = [-40 -40 40 40; -40 0 0 40]';

			psi = u(3);

			rot1 = [cos(psi*pi/180) -sin(psi*pi/180); sin(psi*pi/180) cos(psi*pi/180)]*[shipXdata(:,1) shipYdata(:,1)]';
			rot2 = [cos(psi*pi/180) -sin(psi*pi/180); sin(psi*pi/180) cos(psi*pi/180)]*[shipXdata(:,2) shipYdata(:,2)]';

			xnew = [rot1(1,:); rot2(1,:)]' + u(1);
			ynew = [rot1(2,:); rot2(2,:)]' + u(2);

			set(hlist(2),'XData',xnew);
			set(hlist(2),'YData',ynew);

			drawnow;
           
		end
	end
	sys=[];
	x0=[];
    
elseif flag == 4 % Return next sample hit

  x0=[];
  
elseif flag==0,
    
    % X and Y range
    xRange = [-1000 3000];
    yRange = [-1000 3000];

    % Initialize the figure for use with this simulation
    ship_anim_init('Ship control');
    shipcontrol = findobj(0,'Name','Ship control');

	shipXdata = [-120 80 80 -120; 80 130 130 80]';
	shipYdata = [-40 -40 40 40; -40 0 0 40]';
	
    % Draw the water
    lane_h = patch([xRange(1) xRange(2) xRange(2) xRange(1)], [yRange(1) yRange(1) yRange(2) yRange(2)], ...
                   [0 1 1],'EraseMode','normal','EdgeColor','none');

    % Draw the ship
    ship_h = patch(shipXdata,shipYdata,[1 0.8 0.5],'erasemode','normal');

    set(gcf, ...
    'Color',[.9 .9 .9], ...
    'UserData',[lane_h ship_h]);
    set(gca, ...
    'XLim',xRange,'YLim',yRange, ...
    'XTick',[],'YTick',[], ...
    'XColor','black','YColor','black', ...
    'Box','on');
    axis equal
    %xlabel('Water Level Control','Color','black');
    set(get(gca,'XLabel'),'Visible','on')

    sys=[0 0 0 3 0 0];
    x0=[];

end;
