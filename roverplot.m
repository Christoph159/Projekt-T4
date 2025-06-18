%% --- Rover ---
% Rover dynamisch als Funktion damit ich das in Simulink aufrufen kann

function roverplot(x, y, psi, roverb, roverl)

    % ---------- Kegel-Objekt persistent speichern ----------
    persistent roverBody;

    % ---------- Initialisierung ----------
    if isempty(roverBody) || ~isvalid(roverBody)
        figure(1); hold on;

        % Erzeuge Kegel-Geometrie (nach oben zeigend)
        [X, Y, Z] = cylinder([0, roverb], 20);
        Z = Z * roverl;

        % Zeichne Dummy-Kegel an Ursprung, leicht über Boden
        X0 = X; Y0 = Y; Z0 = Z + 0.05;

        roverBody = surf(X0, Y0, Z0, 'FaceColor', 'k', 'EdgeColor', 'none', 'DisplayName', 'Rover');
    end

    % ---------- Aktualisierung für aktuellen Zustand ----------
    % Neuer Kegel, skaliert
    [X, Y, Z] = cylinder([0, roverb], 20);
    Z = Z * roverl;

    % Punkte in Spaltenform (3xN)
    pts = [X(:), Y(:), Z(:)]';

    % Drehe Kegel von Z-Richtung in X-Richtung (−90° um Y)
    Ry = [cos(-pi/2), 0, sin(-pi/2);
          0,          1, 0;
         -sin(-pi/2), 0, cos(-pi/2)];
    pts = Ry * pts;

    % Drehe um psi (in XY-Ebene)
    Rz = [cos(psi), -sin(psi), 0;
          sin(psi),  cos(psi), 0;
               0,         0,   1];
    pts = Rz * pts;

    % Verschiebe in Zielposition
    pts(1,:) = pts(1,:) + x;
    pts(2,:) = pts(2,:) + y;
    pts(3,:) = pts(3,:) + 0.05;  % leicht über Boden

    % Zurück in Kegelstruktur (2x21)
    Xr = reshape(pts(1,:), size(X));
    Yr = reshape(pts(2,:), size(Y));
    Zr = reshape(pts(3,:), size(Z));

    % ---------- Objekt aktualisieren ----------
    set(roverBody, 'XData', Xr, 'YData', Yr, 'ZData', Zr);
    drawnow;  % sofortiges Neuzeichnen
end
