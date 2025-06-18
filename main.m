%% Initialisierung der Rover-Parameter%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Geometrische Parameter des Rovers
roverl = 0.1;          % Länge [m]
roverb = 0.2;          % Breite [m]
roverh = 0.2;          % Höhe [m]
rover_radr = 0.05;     % Radradius [m]#
rad_l = 0.05; 
rad_b = 0.025;


sp = [1,1];             %Startpunkt hier Zeilenvektor [x y]
x = sp(1);
y = sp(2);
X_sp = sp(1);
Y_sp = sp(2);
zp = [5,5];             %Zielpunkt  hier Zeilenvektor [x y]

hindernisse = [2,2,0.5; 2,3.5,0.3; 3,4,0.5];          %Hindernisse als Kreise [x y radius]

%%
%statisches Plotfile:
%% 3D-Visualisierung des fahrenden Rovers mit Hindernissen, Start & Ziel
% clear; close all; clc;

figure(1);                                          % öffnet neues Grafikfenster
axis equal;                                         % Achsen sollen die selbe Skalierung haben
grid on;                                            % aktiviert das Hintergrundraster
xlabel('X [m]'); ylabel('Y [m]'); zlabel('Z [m]');  % Achsen beschriften
xlim([-1 6]); ylim([-1 6]); zlim([0 1]);            % x-&, y-Achse von -1 bis 6; z setzt die Höhe von 0 bis 1 
view(45, 30);                                       % 3D-Perspektive (45 Grad um z-Achse & 30 Grad über xy Ebene)
hold on;                                            % hält aktuellen Plot, damit man mehrere Elemente hinzufügen kann
title('3D-Visualisierung des fahrenden Rovers');
x_boden = [-1 6 6 -1];
y_boden = [-1 -1 6 6];
z_boden = [0 0 0 0];
boden = fill3(x_boden, y_boden, z_boden, [0.65 0.65 0.7]);  % RGB für Grün


%% --- Start- & Zielpunkt ---
% Startpunkt (grün, Marker 'o', Größe 10)
startp = plot3(sp(1), sp(2), 0.05, 'go', 'MarkerSize', 6, 'MarkerFaceColor', 'g'); % zeichnet 3D-Raum z=0.05 "Leicht über Boden"

% Zielpunkt (rot, Marker 'o', Größe 10)
zielp = plot3(zp(1), zp(2), 0.05, 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'r');

%% --- Hindernisse ---
% Parameter für die Kreise
alpha = linspace(0, 2*pi, 50); % Winkel für den Kreis von 0 bis 2pi

hold on;
for i = 1:size(hindernisse,1) % Schleife über alle Hindernisse; size gibt Anzahl der Zeilen zrk.
                              % ,1 = Anzahl der Zeilen von Matrix; ,2 wäre Spalten 
    xh = hindernisse(i,1);
    yh = hindernisse(i,2);
    r = hindernisse(i,3);
    z = 0; % alle auf Boden
    plot3(xh + r*cos(alpha), yh + r*sin(alpha), z*ones(size(alpha)), 'k', 'LineWidth', 2);
    % ones(size(theta)) erzeugt Vektor mit gleichen Länge wie theta
end

hindernis = plot3(NaN,NaN,NaN,'k','LineWidth',2);
%% ----------------------------
% Pfad berechnen (einmalig)
[x_pfad, y_pfad] = pfadplaner(sp, zp, hindernisse,roverb);

% Pfad anzeigen im vorhandenen Plot (Ebene etc. ist schon da)
pfad = plot3(x_pfad, y_pfad, 0.05 * ones(size(x_pfad)), 'b-', 'LineWidth', 2);  % leicht über Bodenhöhe
%%Legende
legend([boden, startp, zielp, hindernis, pfad], ...
       {'Boden', 'Start', 'Ziel', 'Hindernisse', 'Pfad'}, ...
       'Location', 'northeastoutside');