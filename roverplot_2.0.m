function roverplot(x, y, psi, roverb, roverl, roverh)
    persistent roverBody;

    if isempty(roverBody) || ~isvalid(roverBody)
        hold on;

        % Roverkörper als Quader mit variabler Höhe roverh
        [Xb, Yb, Zb] = ndgrid([-1 1]*roverb/2, [-1 1]*roverl/2, [0 1]*roverh);
        Xb = Xb(:); Yb = Yb(:); Zb = Zb(:);
        bodyFaces = convhull(Xb, Yb, Zb);

        roverBody = patch('Vertices', [Xb Yb Zb], ...
                          'Faces', bodyFaces, ...
                          'FaceColor', [0.9, 0.9, 0.9], ...
                          'EdgeColor', 'none');
    end

    %% Transformation des Rovers im Raum
    T = makehgtform('zrotate', psi, 'translate', [x, y, roverh/2]);
    [Xb, Yb, Zb] = ndgrid([-1 1]*roverb/2, [-1 1]*roverl/2, [0 1]*roverh);
    pts = [Xb(:), Yb(:), Zb(:), ones(numel(Xb),1)]';
    ptsT = T * pts;

    set(roverBody, 'Vertices', ptsT(1:3,:)', 'DisplayName', 'Rover');
    drawnow;
end
