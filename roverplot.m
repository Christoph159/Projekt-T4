function roverplot(x, y, psi, roverb, roverl, roverh, rover_radr)
    persistent roverBody wheelPatches;

    if isempty(roverBody) || ~isvalid(roverBody)
        hold on;

        % --- ROVERKÖRPER als Quader ---
        [Xb, Yb, Zb] = ndgrid([-1 1]*roverb/2, [-1 1]*roverl/2, [0 1]*roverh);
        Xb = Xb(:); Yb = Yb(:); Zb = Zb(:);
        bodyFaces = convhull(Xb, Yb, Zb);

        roverBody = patch('Vertices', [Xb Yb Zb], ...
                          'Faces', bodyFaces, ...
                          'FaceColor', [0.9, 0.9, 0.9], ...
                          'EdgeColor', 'none', ...
                          'DisplayName', 'Rover');

        % --- RÄDER ALS KUGELN ---
        wheelPatches = gobjects(4,1);
        wheelOffsetX = roverb/2 + rover_radr/2;
        wheelOffsetY = roverl/2 - rover_radr;

        wheelPositions = [ % [xOffset, yOffset]
            -wheelOffsetX,  wheelOffsetY;
            -wheelOffsetX, -wheelOffsetY;
             wheelOffsetX,  wheelOffsetY;
             wheelOffsetX, -wheelOffsetY];

        % Kugel erzeugen
        [Xs, Ys, Zs] = sphere(12);  % 12 = Auflösung der Kugel
        Xs = rover_radr * Xs;
        Ys = rover_radr * Ys;
        Zs = rover_radr * Zs;

        for i = 1:4
            Xw = Xs + wheelPositions(i,1);
            Yw = Ys + wheelPositions(i,2);
            Zw = Zs;

            wheelPatches(i) = surf(Xw, Yw, Zw, ...
                                   'FaceColor', [0.1, 0.1, 0.1], ...
                                   'EdgeColor', 'none');

            if i == 1
                set(wheelPatches(i), 'DisplayName', 'Räder');
            else
                set(wheelPatches(i), 'HandleVisibility', 'off');
            end
        end
    end

    %% --- Transformation Roverkörper ---
    T = makehgtform('zrotate', psi, 'translate', [x, y, roverh/2]);
    [Xb, Yb, Zb] = ndgrid([-1 1]*roverb/2, [-1 1]*roverl/2, [0 1]*roverh);
    ptsBody = [Xb(:), Yb(:), Zb(:), ones(numel(Xb),1)]';
    ptsBodyT = T * ptsBody;
    set(roverBody, 'Vertices', ptsBodyT(1:3,:)');

    %% --- Transformation Räder (Kugeln) ---
    wheelOffsetX = roverb/2 + rover_radr/2;
    wheelOffsetY = roverl/2 - rover_radr;
    wheelPositions = [
        -wheelOffsetX,  wheelOffsetY;
        -wheelOffsetX, -wheelOffsetY;
         wheelOffsetX,  wheelOffsetY;
         wheelOffsetX, -wheelOffsetY];

    [Xs, Ys, Zs] = sphere(12);
    Xs = rover_radr * Xs;
    Ys = rover_radr * Ys;
    Zs = rover_radr * Zs;

    for i = 1:4
        % Transformation jedes Kugelpunkts
        pts = [Xs(:) + wheelPositions(i,1), ...
               Ys(:) + wheelPositions(i,2), ...
               Zs(:), ...
               ones(numel(Xs),1)]';
        ptsT = T * pts;

        % In neue Form zurückbringen
        n = size(Xs, 1);
        Xt = reshape(ptsT(1,:), n, n);
        Yt = reshape(ptsT(2,:), n, n);
        Zt = reshape(ptsT(3,:), n, n);

        set(wheelPatches(i), 'XData', Xt, 'YData', Yt, 'ZData', Zt);
    end
    drawnow;
end
