function roverplot(x, y, psi, roverb, roverl, roverh, rover_radr)
    persistent roverBody wheelPatches;

    if isempty(roverBody) || ~isvalid(roverBody) % wurde rover schon gezeichnet/noch gültig?
        hold on;

        % --- ROVERKÖRPER als Quader ---
        [Xb, Yb, Zb] = ndgrid([-1 1]*roverb/2, [-1 1]*roverl/2, [0 1]*roverh); % ndgrid baut 3D-Gitter für Eckpunkte
        Xb = Xb(:); Yb = Yb(:); Zb = Zb(:); % Erzeugung von Punktlisten/Spaltenvektor
        bodyFaces = convhull(Xb, Yb, Zb); % Hülle erzeugen

        roverBody = patch('Vertices', [Xb Yb Zb], ...
                          'Faces', bodyFaces, ...
                          'FaceColor', [0.9, 0.9, 0.9], ...
                          'EdgeColor', 'none', ...
                          'DisplayName', 'Rover');

        % --- RÄDER ALS KUGELN ---
        wheelPatches = gobjects(4,1);
        wheelOffsetX = roverb/2 + rover_radr/2;
        wheelOffsetY = roverl/2 - rover_radr;

        % Roverräder zum Mittelpunkt des Rovers
        wheelPositions = [ % [xOffset, yOffset]
            -wheelOffsetX,  wheelOffsetY;   % vorne links
            -wheelOffsetX, -wheelOffsetY;   % vorne rechts
             wheelOffsetX,  wheelOffsetY;   % hinten links
             wheelOffsetX, -wheelOffsetY];  % hinten rechts

        % Kugel erzeugen
        [Xs, Ys, Zs] = sphere(12);  % 12 = Auflösung der Kugel
        Xs = rover_radr * Xs;
        Ys = rover_radr * Ys;
        Zs = rover_radr * Zs;

        for i = 1:4 % Verschieben der Räder
            Xw = Xs + wheelPositions(i,1); % x-Koordinaten
            Yw = Ys + wheelPositions(i,2); % y-Koordinaten
            Zw = Zs;

            wheelPatches(i) = surf(Xw, Yw, Zw, 'FaceColor', [0.1, 0.1, 0.1], ...
                                   'EdgeColor', 'none');

            if i == 1 % Legende nur für 1 Rad, nicht alle 4
                set(wheelPatches(i), 'DisplayName', 'Räder');
            else
                set(wheelPatches(i), 'HandleVisibility', 'off');
            end
        end
    end

    %% --- Transformation Roverkörper ---
    T = makehgtform('zrotate', psi, 'translate', [x, y, roverh/2]); % Transformationsmatrix (Rotation um z und dann Verschieben)
    [Xb, Yb, Zb] = ndgrid([-1 1]*roverb/2, [-1 1]*roverl/2, [0 1]*roverh);
    ptsBody = [Xb(:), Yb(:), Zb(:), ones(numel(Xb),1)]';
    ptsBodyT = T * ptsBody; %Transformation der Punkte mit T (Drehung + Verschiebung)
    set(roverBody, 'Vertices', ptsBodyT(1:3,:)');

    %% --- Transformation Räder (Kugeln) ---
    wheelOffsetX = roverb/2 + rover_radr/2;
    wheelOffsetY = roverl/2 - rover_radr;
    wheelPositions = [ % Positionen der Räder relativ zum Roverzentrum
        -wheelOffsetX,  wheelOffsetY;
        -wheelOffsetX, -wheelOffsetY;
         wheelOffsetX,  wheelOffsetY;
         wheelOffsetX, -wheelOffsetY];

    [Xs, Ys, Zs] = sphere(12); % erzeugt Kugel mit Auflösung 12
    Xs = rover_radr * Xs;   % Kugel skalieren
    Ys = rover_radr * Ys;
    Zs = rover_radr * Zs;

    for i = 1:4
        % Transformation jedes Kugelpunkts
        pts = [Xs(:) + wheelPositions(i,1), ...
               Ys(:) + wheelPositions(i,2), ...
               Zs(:), ...
               ones(numel(Xs),1)]';
        ptsT = T * pts; % 4xN-Matrix

        % In neue Form zurückbringen für 3D-Darstellung
        n = size(Xs, 1);
        Xt = reshape(ptsT(1,:), n, n); % erste Zeile holen von Matrix für x
        Yt = reshape(ptsT(2,:), n, n);
        Zt = reshape(ptsT(3,:), n, n);

        set(wheelPatches(i), 'XData', Xt, 'YData', Yt, 'ZData', Zt);
    end
    drawnow;
end
