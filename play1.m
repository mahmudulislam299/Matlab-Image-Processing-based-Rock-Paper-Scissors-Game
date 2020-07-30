function varargout = play1(varargin)
% PLAY1 MATLAB code for play1.fig
%      PLAY1, by itself, creates a new PLAY1 or raises the existing
%      singleton*.
%
%      H = PLAY1 returns the handle to a new PLAY1 or the handle to
%      the existing singleton*.
%
%      PLAY1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLAY1.M with the given input arguments.
%
%      PLAY1('Property','Value',...) creates a new PLAY1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before play1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to play1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help play1

% Last Modified by GUIDE v2.5 09-Jul-2017 23:30:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @play1_OpeningFcn, ...
                   'gui_OutputFcn',  @play1_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before play1 is made visible.
function play1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to play1 (see VARARGIN)

% Choose default command line output for play1
handles.output = hObject;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ah = axes('unit', 'normalized', 'position', [0 0 1 1]);
bg = imread('rock.jpg'); imagesc(bg);
set(ah,'handlevisibility','off','visible','off')
uistack(ah, 'bottom');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes play1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = play1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function box_Callback(hObject, eventdata, handles)
% hObject    handle to box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of box as text
%        str2double(get(hObject,'String')) returns contents of box as a double


% --- Executes during object creation, after setting all properties.
function box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
pp=str2double(get(handles.box,'string'))
p1name=get(handles.p1n,'string')
p2name='COMPUTER';
s2='  WINNER';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vid=ipcam('http://192.168.0.100:8080/video');

point1=0;
point2=0;
pause(1);
in1=imread('1.jpg');
in2=imread('2.jpg');
in3=imread('3.jpg');
in4=imread('go.jpg');


for jj=1:1:100000000
 stop=1; 
 pl1=0;
 pl2=0;
 close all;
 imshow(in3);
 pause(1);
 imshow(in2);
 pause(1);
 imshow(in1);
 pause(1);
 imshow(in4);
 pause(2);
while(1) %(stop<25)
    pl1=0;
    stop=stop+1;
    red=0;
    blue=0;
    data=snapshot(vid);
    data=imrotate(data,-90);
    data=flipdim(data,2);
    [a, b, c]=size(data);

    
    diff_imR = imsubtract(data(:,:,1), rgb2gray(data));%subtracting red component
    diff_imB = imsubtract(data(:,:,3), rgb2gray(data));%subtracting blue component
    
    diff_imR = medfilt2(diff_imR, [3 3]);
    diff_imB = medfilt2(diff_imB, [3 3]);
    
    diff_imR = im2bw(diff_imR,0.25);
    diff_imB = im2bw(diff_imB,0.25);
    
    diff_imR = bwareaopen(diff_imR,300);
    diff_imB = bwareaopen(diff_imB,300);
    
    bwR = bwlabel(diff_imR, 8);
    bwB = bwlabel(diff_imB, 8);
%     figure(1), imshow(bwR), title('rrr');
%     figure(2), imshow(bwB), title('bbb');
    
    statsR = regionprops(bwR,'Area', 'BoundingBox', 'Centroid');
    statsB = regionprops(bwB,'Area', 'BoundingBox', 'Centroid');
    
    figure(1)
    imshow(data)
    
    hold on
     rednum=length(statsR);
     bluenum=length(statsB);
     
        
    
     for g = 1:length(statsR)
        
        bb = statsR(g).BoundingBox;
        centroidR = statsR(g).Centroid;
        red=1;
        rectangle('Position',bb,'EdgeColor','r','LineWidth',3)
        plot(centroidR(1),centroidR(2), 'm+','LineWidth',2)
        a=text(centroidR(1),centroidR(2), strcat('X: ', num2str(round(centroidR(1))), '    Y: ', num2str(round(centroidR(2)))));
        set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'black');
     hold on;
     end
     
%      for v = 1:length(statsB)
%         
%         dd = statsB(v).BoundingBox;
%         centroidB = statsB(v).Centroid;
%         blue=1;
%         rectangle('Position',dd,'EdgeColor','b','LineWidth',2)
%         plot(centroidB(1),centroidB(2), '-m+','LineWidth',2)
%         b=text(centroidB(1),centroidB(2), strcat('X: ', num2str(round(centroidB(1))), '    Y: ', num2str(round(centroidB(2)))));
%         set(b, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'black');
%         
%      hold on 
%      end
     hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     if rednum==1
      pl1=1;
      rn=text(100,100, 'ROCK');
      set(rn, 'FontName', 'Snap ITC', 'FontWeight', 'bold', 'FontSize', 40, 'Color', 'red');
     elseif rednum==3
       pl1=2;
       rn=text(100,100, 'scissor');
       set(rn, 'FontName', 'Snap ITC', 'FontWeight', 'bold', 'FontSize', 40, 'Color', 'red');
     elseif ( rednum==6)
       pl1=3;
       rn=text(100,100, 'paper');
       set(rn, 'FontName', 'Snap ITC', 'FontWeight', 'bold', 'FontSize', 40, 'Color', 'red');
     end
     
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%      if bluenum==1
%       pl2=1;
%       bn=text(1000,100, 'ROCK');
%       set(bn, 'FontName', 'Snap ITC', 'FontWeight', 'bold', 'FontSize', 40, 'Color', 'blue');
%      elseif bluenum==3
%        pl2=2;
%        bn=text(1000,100, 'scissor');
%        set(bn, 'FontName', 'Snap ITC', 'FontWeight', 'bold', 'FontSize', 40, 'Color', 'blue');
%      elseif bluenum==6
%        pl2=3;
%        bn=text(1000,100, 'paper');
%        set(bn, 'FontName', 'Snap ITC', 'FontWeight', 'bold', 'FontSize', 40, 'Color', 'blue');
%      end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 pause(0.10);
 if(pl1~=0 && stop>20) 
     break;
 end
end %while
close all
%%wh

pl2= round(rand(1)*2)+1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
im11=imread('1r.jpg');
im12=imread('1s.jpg');
im13=imread('1p.jpg');
im21=imread('2r.jpg');
im22=imread('2s.jpg');
im23=imread('2p.jpg');

        
if pl1 == 1
    if pl2 == 1
        subplot(1,2,1), imshow(im11)
        subplot(1,2,2), imshow(im21)
        pause(2);
        [y1,Fs1] = audioread('tie.wav');
        sound(y1,Fs1);
        figure,imshow('tie.bmp')
        
        
    elseif pl2 == 2
        subplot(1,2,1), imshow(im11)
        subplot(1,2,2), imshow(im22)
        pause(2);
        [y1,Fs1] = audioread('pl1.wav');
        sound(y1,Fs1);
        point1=point1+1;
        wp=imread('winner.jpg');
        hold on
        wp1=insertText(wp,[60 500], strcat(p1name,s2),'FontSize',80,'BoxColor','red', ...
            'BoxOpacity',0.6,'TextColor','white');
        figure,imshow(wp1)
        hold off
        
        
    elseif pl2 == 3
        subplot(1,2,1), imshow(im11)
        subplot(1,2,2), imshow(im23)
        pause(2);
        [y1,Fs1] = audioread('pl2.wav');
        sound(y1,Fs1);
        point2=point2+1;
        wp=imread('winner.jpg');
        hold on
        wp1=insertText(wp,[60 500], strcat(p2name,s2),'FontSize',80,'BoxColor','red', ...
            'BoxOpacity',0.6,'TextColor','white');
        figure,imshow(wp1)
        hold off
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif pl1 == 2
    if pl2 == 1
        subplot(1,2,1), imshow(im12)
        subplot(1,2,2), imshow(im21)
        pause(2);
        gameResult = 1;
        [y1,Fs1] = audioread('pl2.wav');
        sound(y1,Fs1);
        point2=point2+1;
        wp=imread('winner.jpg');
        hold on
        wp1=insertText(wp,[60 500], strcat(p2name,s2),'FontSize',80,'BoxColor','red', ...
            'BoxOpacity',0.6,'TextColor','white');
        figure,imshow(wp1)
        hold off
        
        
    elseif pl2 == 2
        subplot(1,2,1), imshow(im12)
        subplot(1,2,2), imshow(im22)
        pause(2);
        [y1,Fs1] = audioread('tie.wav');
        sound(y1,Fs1);
        figure,imshow('tie.bmp')
        
        
    elseif pl2 == 3
        subplot(1,2,1), imshow(im12)
        subplot(1,2,2), imshow(im23)
        pause(2);
        [y1,Fs1] = audioread('pl1.wav');
        sound(y1,Fs1);
        point1=point1+1;
        wp=imread('winner.jpg');
        hold on
        wp1=insertText(wp,[60 500], strcat(p1name,s2),'FontSize',80,'BoxColor','red', ...
            'BoxOpacity',0.6,'TextColor','white');
        figure,imshow(wp1)
        hold off
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
elseif pl1 == 3
    if pl2 == 1
        subplot(1,2,1), imshow(im13)
        subplot(1,2,2), imshow(im21)
        pause(2);
        [y1,Fs1] = audioread('pl1.wav');
        sound(y1,Fs1);
        point1=point1+1;
        wp=imread('winner.jpg');
        hold on
        wp1=insertText(wp,[60 500], strcat(p1name,s2),'FontSize',80,'BoxColor','red', ...
            'BoxOpacity',0.6,'TextColor','white');
        figure,imshow(wp1)
        hold off
        
        
    elseif pl2 == 2
        subplot(1,2,1), imshow(im13)
        subplot(1,2,2), imshow(im22)
        pause(2);
        gameResult = 1;
        [y1,Fs1] = audioread('pl2.wav');
        sound(y1,Fs1);
        point2=point2+1;
        wp=imread('winner.jpg');
        hold on
        wp1=insertText(wp,[60 500], strcat(p2name,s2),'FontSize',80,'BoxColor','red', ...
            'BoxOpacity',0.6,'TextColor','white');
        imshow(wp1)
        hold off
        
        
    elseif pl2 == 3
        subplot(1,2,1), imshow(im13)
        subplot(1,2,2), imshow(im23)
        pause(2);
        [y1,Fs1] = audioread('tie.wav');
        sound(y1,Fs1);
        figure,imshow('tie.bmp')
    end
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
pause(5);
close all;
    if(point1==pp || point2==pp)
        break;
    end
point1
point2
end
disp('game over')
figure, imshow('GameOver.png');
pause(2)
point1
point2
if point1>point2
    w=p1name;
    tp=point1;
else
    w=p2name;
    tp=point2;
end
close all
s3=' CHAMPION'
wp=imread('champ.jpg');
hold on
wp1=insertText(wp,[100 600], strcat(w,s3),'FontSize',100,'BoxColor','red', ...
    'BoxOpacity',0.6,'TextColor','white');
imshow(wp1)
[y1,Fs1] = audioread('champ.mp3');
        sound(y1,Fs1);
hold off


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
close


function p2n_Callback(hObject, eventdata, handles)
% hObject    handle to p2n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p2n as text
%        str2double(get(hObject,'String')) returns contents of p2n as a double


% --- Executes during object creation, after setting all properties.
function p2n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p2n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p1n_Callback(hObject, eventdata, handles)
% hObject    handle to p1n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p1n as text
%        str2double(get(hObject,'String')) returns contents of p1n as a double


% --- Executes during object creation, after setting all properties.
function p1n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p1n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
