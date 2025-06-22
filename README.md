Simulationsanleitung - *Rover-Projekt*

Dateienübersicht:
Laden Sie am besten alle sieben Dateien in einen gemeinsamen Ordner, um die Simulation korrekt auszuführen:
- Model_Rover.slx – Simulink-Modell zur Hauptsimulation
- main.m – Startskript zur Initialisierung und Visualisierung
- pfadplaner.m – Pfadplanung des Rovers
- rotate_rect.m – Hilfsfunktion zur Rotation vom Rover
- roverplot.m – Darstellung des Rovers in der 3D-Visualisierung
- update_reader.m – Aktualisierung der vier Radwinkel / Draufsicht des Rovers
- update_visu.m – Aktualisierung der grafischen Visualisierung
  
Welche Parameter kann man ändern? 
In der Datei main.m (Z. 2–11) können verschiedene Parameter geändert werden, z. B.:
- Größe des Rovers (Länge, Breite, Höhe, Radgrößen)
- Start- und Zielpunkt
- Positionen und Anzahl der Hindernisse (in der Form [x, y, Radius])

Wenn weniger Hindernisse gewünscht sind, können einfach Zeilen aus der Hindernisliste auskommentiert werden.
Dies eignet sich ideal für eigene Tests und Szenarien.

Simulation starten

Es gibt zwei Möglichkeiten, das Programm auszuführen:

Nur Visualisierung (ohne Simulation des Rovers):
- Öffnen Sie die Datei main.m und klicken Sie auf „Run“. Dies zeigt die vorbereitete Umgebung mit Start-/Zielpunkten und Hindernissen – jedoch ohne bewegten Rover.

Komplette Simulation (inkl. Roverbewegung):
- Öffnen Sie das Simulink-Modell Model_Rover.slx und klicken Sie auf „Run“. Dadurch wird:
    - die Bewegung des Rovers animiert
    - die Visualisierung aktualisiert (Top-Down-Ansicht)
    - die Entwicklung der Zustandsgrößen x, y und ψ (psi) im Scope dargestellt

_Wichtiger Hinweis_
Bitte vermeiden Sie, den Startpunkt innerhalb eines Hindernisses zu platzieren – der Rover fährt in diesem Fall dennoch los, da keine Kollisionsprüfung zu Beginn erfolgt.
  
