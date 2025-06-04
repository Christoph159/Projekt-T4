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


%% --- Rover-Kegel ---

r_rover = 0.1; % Kegelradius
roverh;        % Kegellänge / Rover

% Kegel entlang der X-Achse (Spitze in X-Richtung)
[Z, Y, X] = cylinder([0 r_rover], 30); % Zylinder mit Spitze entlang der X-Achse
X = X * roverh;                        % Länge anpassen

% Richtung vom Startpunkt zum Ziel (Hindernis) berechnen
richtung = zp - sp;  % Richtung zum Zielpunkt (Hindernis)
theta = atan2(richtung(2), richtung(1));  % Winkel in der XY-Ebene

% Jetzt die entgegengesetzte Richtung berechnen (invertieren)
theta = theta + pi;  % Kegelspitze 180 Grad drehen, um die entgegengesetzte Richtung zu bekommen

% Rotation des Kegels in XY-Ebene (um Z-Achse)
Xr = cos(theta)*X - sin(theta)*Y;
Yr = sin(theta)*X + cos(theta)*Y;
Zr = Z;

% Den Kegel so verschieben, dass das Ende bei (0, 0) ist
% Die Spitze ist um 'roverh' entfernt, also verschieben wir den Kegel um 'roverh'
Xr = Xr - roverh * cos(theta);  % Verschiebung entlang der X-Achse
Yr = Yr - roverh * sin(theta);  % Verschiebung entlang der Y-Achse
Zr = Zr + 0.05;  % Etwas anheben, damit er nicht auf dem Boden verschwindet

% Kegel bleibt beim Ende bei (0, 0), keine weitere Verschiebung notwendig
Xr = Xr + sp(1);  % Kegel bleibt bei sp(1)
Yr = Yr + sp(2);  % Kegel bleibt bei sp(2)

% Plotten
surf(Xr, Yr, Zr, 'FaceColor', 'blue', 'EdgeColor', 'none');


%r_rover = 0.1; h_rover = 0.3;  % Kegelparameter
%[X, Y, Z] = cylinder([0 r_rover], 30);  % Zylinder erstellen
%Z = Z * h_rover;  % Höhe des Kegels

% Kegelposition initialisieren (am Startpunkt)
%Xr = X; Yr = Y; Zr = Z + 0.05;  % Anhebung der Kegelspitze
