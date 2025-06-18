function roverplot(X_sp, Y_sp, x, y, psi, roverb, roverl)
    % ---------- Kegel-Objekt persistent speichern ----------
    persistent roverBody;
    % ---------- Initialisierung ----------
    if isempty(roverBody) || ~isvalid(roverBody)
        figure(1); 
        hold on;
 
        % Erzeuge Kegel-Geometrie (nach oben zeigend)
        [X, Y, Z] = cylinder([0, roverb], 20);Z = Z * roverl;

        % Zeichne Dummy-Kegel an Startpunkt, leicht über Boden
        X0 = X + X_sp; Y0 = Y+Y_sp; Z0 = Z + 0.05;

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
    xlabel('X [m]'); ylabel('Y [m]'); zlabel('Z [m]');
    drawnow;  % sofortiges Neuzeichnen
end