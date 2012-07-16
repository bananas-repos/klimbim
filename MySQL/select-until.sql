/* 
Nun es gibt keinen SELECT UNTIL Befehl in MySQL. Nein es soll jediglich nur die Möglichkeit erläutert wie man so was realisieren kann.

Hier nun mein Beispiel bzw. das "Problem".
Man stelle sich folgende Tabelle vor:

customerId|punkte|preis|wert|geld
1|20|431|22|849
2|51|732|8|469
3|57|24|886|75
4|2|47|8|27
Wenn man nun eine Übersicht möchte die zeigt welcher Kunde (identifiziert anhand der customerId), sotiert nach Punkten auf welchem Platz ist.

Nun da genügt folgender SQL Befehl:
*/

SELECT * FROM `customerTable` ORDER BY `punkte` DESC

/*
Dies erstellt ja eine Übersicht von allen in dieser Tabelle. Man kann auch noch ein Limit einbauen, aber es werden immer alle angezeigt.

Der Platz in der Liste wird anhand der Sortiertung bzw. dem ORDER BY festgelegt und zeigt sich erster nach dem auslesen und anzeigen der Daten.
Somit wäre Kunde 3 an erster Stelle bzw. Platz. Dies kann für den Kunden sehr von Intresse sein. Man möchte ja wissen ob man besser ist als die anderen.

Wenn man nun also das Ergbnis darstellt muss man die Positionsnummer manuell davorschreiben.
Ist bei einer Übersicht ja auch keine Problem. Einfach eine Schleife die alle Ergebnisse der Abfrage durchgeht und dabei eine aufsteigende Nummer pro Eintrag mit anzeigen/ausgeben.

 

Nun hat ja fast jede Übersicht auch einen Detailansicht auf der mehr Informationen angezeigt werden die auf der Übersicht nicht vorhanden sind.

Auf der Detailseite soll aber auch die Position nach einem bestimmten Kriterium angezeigt werden.

Ok, SQL Abfrage machen und durchnummerieren und dann die Nummer für diese Detailseite eines bestimmten Kunden anzeigen.

Hmm aber warum das Selbe tun wie auf der Übersichtsseite ?
Warum nochmals alle Abfragen nur um eine Information zu bekommen ?
Warum gefahr laufen den Arbeitspeicher zuzumüllen ?

Wenn man eine Anwendung entwickelt, sollte man immer beachten, dass diese auch unter "last" funktioniert und man immer genug Daten zum testen hat.

Denn wenn mal so eine Tabelle über 1000 oder sogar Millionen Einträge hat, was dann ?
Da wird so eine SQl Abfrage ein wenig länger dauern und irgendwann sagt, PHP "no memory" etc.

Nun möchte man ja nur die Position wissen. Also werden eigentlich die Daten/Zeilen die nach der gewünschten customerId nicht mehr benötigt.

Dies lässt sich mit folger Abfrage erledigen:
*/

SELECT count(*) AS rank
FROM `table`
WHERE active = 1
AND punkte >
(SELECT punkte FROM `table` WHERE customerId = 88)
/*
Wir zählen als wie viele Einträge größer als der Kunde ist. Zu dem Ergebnis muss man da nur noch +1 machen und schon hat man die Position in der Liste wie auf der Übersicht.

So einfach und man hat nur die Daten die man braucht und kann jeder Zeit die Bedingungen ändern.
*/