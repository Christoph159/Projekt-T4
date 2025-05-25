%% Initialisierung der Rover-Parameter%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Geometrische Parameter des Rovers
roverl = 0.5;          % Länge [m]
roverb = 0.3;          % Breite [m]
roverh = 0.2;          % Höhe [m]
x = 0;
y = 0;
psi = 0;
rover_radr = 0.05;     % Radradius [m]


% theta = 3;              %Anfangswinkel [rad/s]
v = 0;                  %Anfangsgeschwindigkeit [m/s]

sp = [0,0];             %Startpunkt [x y]   
zp = [5,5];             %Zielpunkt  [x y]

hindernisse = [
    2,2,1.3
    3,4,0.7
    4,4,0.5 ];          %Hindernisse als Kreise [x y radius]

dt = 0.01;               %Zeitintervall [s]
% sim_time = 20;          %Simulationsdauer [s]    
