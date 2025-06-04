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

%% --- Start- & Zielpunkt als Kugeln darstellen ---
[xs, ys, zs] = sphere(20);  % Kugeloberfläche erstellen mit 20er Auflösung
r_kugel = 0.1;  % Kugelradius

% Startpunkt: grün
% surf = zeichnet 3D-Oberfläche / Kugeloberfläche
start = surf(xs*r_kugel + sp(1), ys*r_kugel + sp(2), zs*r_kugel + 0.05, ... % Größe der Kugel (zB: xs*r_kugel) und Verschiebung auf den Achsen (zB: sp(1))
     'FaceColor', 'green', 'EdgeColor', 'none');                            % z-Achse nach oben verschieben mit 0.05, damit Punkt auf "Boden"
text(sp(1) -0.2 , sp(2), 0.05 -0.4, 'Start', 'FontSize', 8, 'Color', 'g');  % Text hinzufügen

% Zielpunkt: rot
ziel = surf(xs*r_kugel + zp(1), ys*r_kugel + zp(2), zs*r_kugel + 0.05, ...  % Hier selbe für Zielpunkt jedoch rote Farbe
     'FaceColor', 'red', 'EdgeColor', 'none')
text(zp(1), zp(2), 0.05 -0.3, 'Ziel', 'FontSize', 8, 'Color', 'r');  % Text hinzufügen
