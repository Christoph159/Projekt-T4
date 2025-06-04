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


%% --- Start- & Zielpunkt ---
% Startpunkt (grün, Marker 'o', Größe 10)
plot3(sp(1), sp(2), 0.05, 'go', 'MarkerSize', 6, 'MarkerFaceColor', 'g'); % zeichnet 3D-Raum z=0.05 "Leicht über Boden"
text(sp(1) - 0.2, sp(2), 0.05 - 0.4, 'Start', 'FontSize', 8, 'Color', 'g'); % -0.2 für nach unten versetzen

% Zielpunkt (rot, Marker 'o', Größe 10)
plot3(zp(1), zp(2), 0.05, 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'r');
text(zp(1), zp(2), 0.05 - 0.3, 'Ziel', 'FontSize', 8, 'Color', 'r');

%% --- Hindernisse ---
% Parameter für die Kreise
theta = linspace(0, 2*pi, 50); % Winkel für den Kreis von 0 bis 2pi

hold on;
for i = 1:size(Hindernisse,1) % Schleife über alle Hindernisse; size gibt Anzahl der Zeilen zrk.
                              % ,1 = Anzahl der Zeilen von Matrix; ,2 wäre Spalten 
    x = Hindernisse(i,1);
    y = Hindernisse(i,2);
    r = Hindernisse(i,3);
    z = 0; % alle auf Boden

    plot3(x + r*cos(theta), y + r*sin(theta), z*ones(size(theta)), 'r', 'LineWidth', 2);
    % ones(size(theta)) erzeugt Vektor mit gleichen Länge wie theta
end

%% --- Rover ---
% Richtung vom Startpunkt zum Zielpunkt
richtung = zp - sp; % zeigt vom Start zum Ziel
richtung = richtung / norm(richtung);  % Normalisieren damit genau 1 lang, damit Länge kontrolliert werden kann mit z.B. roverl

% Skalierung des Richtungspfeils ("Roverlänge")
roverl;

% Endpunkt des Pfeils berechnen
endpunkt = sp + roverl * richtung; 

% 3D-Pfeil zeichnen mit quiver3
quiver3(sp(1), sp(2), 0.05, ...    % Startpunkt: (0, 0, 0.05)
        richtung(1), richtung(2), 0.02, ...  % Richtung: (0.7071, 0.7071, 0.02)
        roverl, 'Color', 'k', 'LineWidth', 2, 'MaxHeadSize', 2); % Länge des Pfeiles + Eigenschaften
