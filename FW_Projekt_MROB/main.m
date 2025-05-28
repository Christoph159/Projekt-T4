%% Initialisierung der Rover-Parameter
% Geometrische Parameter des Rovers
roverl = 0.4;          % Länge [m]
roverb = 0.3;          % Breite [m]
roverh = 0.2;          % Höhe [m]

rover_radr = 0.05;     % Radradius [Rad1-4 selber Radradius] 

% Start- und Zielpunkt
sp = [0, 0];
zp = [5, 5];

% Hindernisse als Kreise [x y radius]
hindernisse = [
    2, 2, 0.5;      % Beispiel mit 0, 2, 0.5
  2.5, 4, 0.7;
    4, 2, 0.6];

% Simulationsparameter
v = 0.02;           % Geschwindigkeit [m/s]
%theta = 0;        % Anfangswinkel [rad/s]

%% 3D-Visualisierung der Umgebung
% clear; close all; clc;
figure(1); axis equal; grid on;                                            
xlabel('X [m]'); ylabel('Y [m]'); zlabel('Z [m]');  % Achsen beschriften
xlim([-1 6]); ylim([-1 6]); zlim([0 1]);            % x-&, y-Achse von -1 bis 6; z setzt die Höhe von 0 bis 1 
view(45, 30);                                       % 3D-Perspektive (45 Grad um z-Achse & 30 Grad über xy Ebene)
hold on;                                            % hält aktuellen Plot, damit man mehrere Elemente hinzufügen kann
title('3D-Visualisierung des fahrenden Rovers');
legend();

x_boden = [-1 6 6 -1];
y_boden = [-1 -1 6 6];
z_boden = [0 0 0 0];
boden = fill3(x_boden, y_boden, z_boden, [0 0.8 0]);  % RGB für saftiges Grün

%% --- Start- & Zielpunkt ---
% Startpunkt (grün, Marker 'o', Größe 10)
startp = plot3(sp(1), sp(2), 0.05, 'go', 'MarkerSize', 6, 'MarkerFaceColor', 'g'); % zeichnet 3D-Raum z=0.05 "Leicht über Boden"

% Zielpunkt (rot, Marker 'o', Größe 10)
zielp = plot3(zp(1), zp(2), 0.05, 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'r');

%% --- Hindernisse ---
% Parameter für die Kreise
alpha = linspace(0, 2*pi, 50); % Winkel für den Kreis von 0 bis 2pi
hold on;

for i = 1:size(hindernisse,1) % Schleife über alle Hindernisse; size gibt Anzahl der Zeilen zurück
    xh = hindernisse(i,1);
    yh = hindernisse(i,2);
    r = hindernisse(i,3);
    z = 0; % alle auf Boden
    hold on;
    plot3(xh + r*cos(alpha), yh + r*sin(alpha), z*ones(size(alpha)), 'k', 'LineWidth', 2);
end

% Dummy-Plot für Legende der Hindernisse (ein einzelner schwarzer Kreisrand)
hindernis = plot3(NaN, NaN, NaN, 'k', 'LineWidth', 2);

%% --- Pfad ---
[x_pfad, y_pfad] = pfadplaner(sp, zp, hindernisse);

% Pfad anzeigen im vorhandenen Plot (Ebene etc. ist schon da)
pfad = plot3(x_pfad, y_pfad, 0.05 * ones(size(x_pfad)), 'b-', 'LineWidth', 2);  % leicht über Bodenhöhe

%% --- Legende ---
legend([boden, startp, zielp, hindernis, pfad], ...
       {'Gras', 'Start', 'Ziel', 'Hindernisse', 'Pfad'}, ...
       'Location', 'northeastoutside');

