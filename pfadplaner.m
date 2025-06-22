function [x_pfad, y_pfad] = pfadplaner(sp, zp, hindernisse,roverl)
    % Eingabe:
    % sp: Startpunkt [x, y]
    % zp: Zielpunkt [x, y]
    % hindernisse: Nx3 [x, y, r] Kreise
    
    % Parameter
    schrittweite = 0.2;                %Genauigkeit
    max_iter = 1000;
    sicherheitsabstand = roverl + 0.25;

    % Initialisierung
    pos = sp;
    ziel = zp;
    x_pfad = pos(1);
    y_pfad = pos(2);

    for k = 1:max_iter
        richtung = (ziel - pos) / norm(ziel - pos);     % Richtung als Zeilen-Einheitsvektor
        neue_pos = pos + schrittweite * richtung;       % ein schritt in Zielrichtung

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
            % ausweichen um 90° 
            winkel = atan2(richtung(2), richtung(1)) + pi/2;
            umgehung = [cos(winkel), sin(winkel)];
            neue_pos = pos + schrittweite * umgehung;    %Ein schritt in ausweichrichtung
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

    %Ziel hinzufügen
    x_pfad(end+1) = ziel(1);
    y_pfad(end+1) = ziel(2);
    
end
