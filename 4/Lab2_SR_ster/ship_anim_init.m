function figNumber=ship_anim_init(namestr)
%ANIMINIT Initializes a figure for Simulink animations.
  
if (nargin == 0)
  namestr = 'Simulink Animation';
end

[existFlag,figNumber]=figflag(namestr);

if ~existFlag,
  % Now initialize the whole figure...
  position=get(0,'DefaultFigurePosition');
  position(3:4)=[500 400];
  figNumber=figure( ...
      'Name',namestr, ...
      'NumberTitle','off', ...
      'BackingStore','off', ...
      'Position',position, ...
      'MenuBar', 'none');
  axes( ...
      'Units','normalized', ...
      'Position',[0.05 0.1 0.9 0.8], ...
      'Visible','off', ...
      'DrawMode','fast');

  %====================================
  % Information for all buttons
  labelColor=[0.8 0.8 0.8];
  yInitPos=0.90;
  top=0.95;
  bottom=0.05;
  left=0.80;
  btnWid=0.15;
  btnHt=0.10;
  % Spacing between the button and the next command's label
  spacing=0.04;
    
  %====================================
  % The CLOSE button
  labelStr='Close';
  callbackStr='close(gcf)';
  closeHndl=uicontrol( ...
      'Style','pushbutton', ...
      'Units','normalized', ...
      'Position',[left bottom btnWid btnHt], ...
      'String',labelStr, ...
      'Callback',callbackStr);
end

cla reset;
set(gca,'DrawMode','fast');
axis off;
