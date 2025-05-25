function [x_pfad, y_pfad] = pfadplaner(sp, zp, hindernisse)
    % Eingabe:
    % sp: Startpunkt [x, y]
    % zp: Zielpunkt [x, y]
    % hindernisse: Nx3 [x, y, r] Kreise
    
    % Parameter
    schrittweite = 0.3;
    max_iter = 1000;
    sicherheitsabstand = 0.3;

    % Initialisierung
    pos = sp;
    ziel = zp;
    x_pfad = pos(1);
    y_pfad = pos(2);

    for k = 1:max_iter
        richtung = (ziel - pos) / norm(ziel - pos);     % aktuelle Richtung
        neue_pos = pos + schrittweite * richtung;

        % Kollision prüfen
        kollidiert = false;
        for i = 1:size(hindernisse, 1)
            hx = hindernisse(i,1);
            hy = hindernisse(i,2);
            hr = hindernisse(i,3) + sicherheitsabstand;
            if norm(neue_pos - [hx, hy]) < hr
                kollidiert = true;
                break;
            end
        end

        if kollidiert
            % Umgehen: 90° nach rechts
            winkel = atan2(richtung(2), richtung(1)) + pi/2;
            umgehung = [cos(winkel), sin(winkel)];
            neue_pos = pos + schrittweite * umgehung;
        end

        % Speichern und weitermachen
        pos = neue_pos;
        x_pfad(end+1) = pos(1);
        y_pfad(end+1) = pos(2);

        % Abbruchbedingung
        if norm(pos - ziel) < schrittweite
            break;
        end
    end

    % Ziel hinzufügen
    x_pfad(end+1) = ziel(1);
    y_pfad(end+1) = ziel(2);
    pfad = [x_pfad, y_pfad];   % Nx2-Matrix
    save('pfad.mat', 'pfad');  % speicherbar für Simulink: From File / From Workspace

end
