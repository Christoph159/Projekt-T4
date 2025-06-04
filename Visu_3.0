%% 3D-Visualisierung des fahrenden Rovers mit Hindernissen, Start & Ziel
% clear; close all; clc;

figure;                                             % öffnet neues Grafikfenster
axis equal;                                         % Achsen sollen die selbe Skalierung haben
grid on;                                            % aktiviert das Hintergrundraster
xlabel('X [m]'); ylabel('Y [m]'); zlabel('Z [m]');  % Achsen beschriften
xlim([-1 6]); ylim([-1 6]); zlim([0 1]);            % x-&, y-Achse von -1 bis 6; z setzt die Höhe von 0 bis 1 
view(45, 30);                                       % 3D-Perspektive (45 Grad um z-Achse & 30 Grad über xy Ebene)
hold on;                                            % hält aktuellen Plot, damit man mehrere Elemente hinzufügen kann
title('3D-Visualisierung des fahrenden Rovers');

%% --- Start- & Zielpunkt als Kugeln darstellen ---
[xs, ys, zs] = sphere(20);  % Kugeloberfläche erstellen mit 20er Auflösung
r_kugel = 0.1;  % Kugelradius

% Startpunkt: grün
% surf = zeichnet 3D-Oberfläche / Kugeloberfläche
start = surf(xs*r_kugel + sp(1), ys*r_kugel + sp(2), zs*r_kugel + 0.05, ... % Größe der Kugel (zB: xs*r_kugel) und Verschiebung auf den Achsen (zB: sp(1))
     'FaceColor', 'green', 'EdgeColor', 'none');                            % z-Achse nach oben verschieben mit 0.05, damit Punkt auf "Boden"

% Zielpunkt: rot
ziel = surf(xs*r_kugel + zp(1), ys*r_kugel + zp(2), zs*r_kugel + 0.05, ...  % Hier selbe für Zielpunkt jedoch rote Farbe
     'FaceColor', 'red', 'EdgeColor', 'none');

%% --- Hindernisse ---
% Parameter für die Kreise
theta = linspace(0, 2*pi, 50); % Kreiswinkel (0 = Startwert [0 Grad]; 2*pi = Endwert [360 Grad] volle Drehung)
                               % 50 = 50 Punkte zwischen 0 und 2pi gleichmäßig (für Glätte) 

% Hindernis 1
r1 = 0.5;                     % Radius [m]
x1 = 2; y1 = 2; z1 = 0;       % Mittelpunkt des Kreises; z = 0, weil auf "Boden"

plot3(x1 + r1*cos(theta), y1 + r1*sin(theta), z1*ones(size(theta)), 'r', 'LineWidth', 2);
% plot3 zeichnet 3D Linie basierend XYZ; Kreis um x1 zentrieren
% r1*cos(theta) verschiebt Mittelpunkt nach rechts/links
% ones: erzeugt Array voller 1 genauso viele wie theta Werte (50)
hold on;

% Hindernis 2
r2 = 0.7;
x2 = 4; y2 = 1; z2 = 0;
plot3(x2 + r2*cos(theta), y2 + r2*sin(theta), z2*ones(size(theta)), 'r', 'LineWidth', 2);

% Hindernis 3
r3 = 0.6;
x3 = 3; y3 = 4; z3 = 0;
plot3(x3 + r3*cos(theta), y3 + r3*sin(theta), z3*ones(size(theta)), 'r', 'LineWidth', 2);

hold off;

%% --- ROVER ---

% Körper als Quader
% rover_koerper = rover_l * rover_b * rover_h;
