function update_raeder(phi,roverl,roverb,rad_l,rad_b)
    persistent radHandles bodyHandle
    % Positionen der vier Räder relativ zum Roverzentrum
    rad_pos = [
         roverl/2,  roverb/2;
         roverl/2, -roverb/2;
        -roverl/2, -roverb/2;
        -roverl/2,  roverb/2
    ];

    if isempty(radHandles) || ~all(isvalid(radHandles)) || isempty(bodyHandle) || ~isvalid(bodyHandle)
        figure(2); 
        clf;
        set(gcf, 'Name', 'Rover Draufsicht');
        axis equal; 
        xlim([-0.5 0.5]); ylim([-0.5 0.5]);
        grid on; 
        title('Rover Draufsicht'); 
        hold on;

        % --- Roverkörper als Rechteck ---
        % Basisrechteck zentriert um Ursprung
        body_corners = 0.5 * [
            -roverl, -roverb;
             roverl, -roverb;
             roverl,  roverb;
            -roverl,  roverb
        ];
        bodyHandle = fill(body_corners(:,1), body_corners(:,2), [0.9 0.9 0.9], ...
                          'EdgeColor', 'k', 'LineWidth', 1.5, 'FaceAlpha', 0.8);

        % --- Räder zeichnen ---
        radHandles = gobjects(4,1);
        for i = 1:4
            corners = rotate_rect(rad_l, rad_b, phi(i)) + rad_pos(i,:);
            radHandles(i) = fill(corners(:,1), corners(:,2), [0.2 0.6 1], 'EdgeColor', 'k');
        end
    else
        % --- Räder aktualisieren ---
        for i = 1:4
            corners = rotate_rect(rad_l, rad_b, phi(i)) + rad_pos(i,:);
            set(radHandles(i), 'XData', corners(:,1), 'YData', corners(:,2));
        end
    end
end
