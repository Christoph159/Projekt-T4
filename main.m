%% Initialisierung der Rover-Parameter
roverl = 0.4;          % Länge [m]
roverb = 0.3;          % Breite [m]
roverh = 0.2;          % Höhe [m]
rover_radr = 0.05;      % Radradius [m]
rad_l = 0.05; 
rad_b = 0.025;

sp = [0, 0];           % Startpunkt
zp = [5, 5];           % Zielpunkt
hindernisse = [1, 2, 0.5; 2, 3, 0.8; 4, 4, 0.4];  % Hindernisse [x y r]
                                                  % wenn nur 2 Hindernisse, dann letzten 3 auskommentieren

%% 3D-Visualisierung des fahrenden Rovers mit schöner Welt
figure(1); clf;
axis equal; grid on; hold on;
xlabel('X [m]'); ylabel('Y [m]'); zlabel('Z [m]');
xlim([-1 6]); ylim([-1 6]); zlim([0 1.5]);
view(45, 30);
title('🌍 Rover-Welt mit Pfadplanung');
%ax = gca;  % aktuelle Achse
%ax.Color = [0.9 0.75 0.7];

%% --- Boden zeichnen (Mars-Farbton) ---
x_boden = [-1 6 6 -1];
y_boden = [-1 -1 6 6];
z_boden = [0 0 0 0];
boden = fill3(x_boden, y_boden, z_boden, [0.8 0.6 0.5]);  % Marsähnlicher Ton

%% --- Start- & Zielpunkt mit Symbolen ---
startp = plot3(sp(1), sp(2), 0.05, 'go', ...
    'MarkerSize', 7, 'MarkerFaceColor', 'g', 'DisplayName', 'Start');

zielp = plot3(zp(1), zp(2), 0.1, 'rp', ...  % 'p' = Pentagon-Marker
    'MarkerSize', 12, 'MarkerFaceColor', 'r', 'DisplayName', 'Ziel');

%% --- Hindernisse darstellen als Kreise am Boden ---
alpha = linspace(0, 2*pi, 100);
hindernisHandles = gobjects(size(hindernisse, 1), 1);

for i = 1:size(hindernisse, 1)
    xh = hindernisse(i,1);
    yh = hindernisse(i,2);
    r = hindernisse(i,3);
    z = 0.01;  % leicht über Boden
    hindernisHandles(i) = fill3(xh + r*cos(alpha), yh + r*sin(alpha), ...
                                z*ones(size(alpha)), [0.3 0.3 0.3], ...
                                'FaceAlpha', 0.8, 'EdgeColor', 'k', ...
                                'LineWidth', 1.5, 'DisplayName', 'Hindernis');
end

%% --- Pfad planen & zeichnen ---
[x_pfad, y_pfad] = pfadplaner(sp, zp, hindernisse, roverl);

pfad = plot3(x_pfad, y_pfad, 0.05 * ones(size(x_pfad)), ...
             'b-', 'LineWidth', 2.5, 'DisplayName', 'Pfad');

%% --- Lichteffekte & Material für mehr Tiefe ---
light('Position', [3 5 10], 'Style', 'infinite');  % Lichtquelle
material dull;
lighting gouraud;

%% --- Legende und Anzeigeelemente ---
legend([boden, startp, zielp, pfad, hindernisHandles(1)], ...
       {'Boden', 'Start', 'Ziel', 'Pfad', 'Hindernisse'}, ...
       'Location', 'northeastoutside');