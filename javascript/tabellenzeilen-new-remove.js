/*
Javascript bietet auch eine Funktion mit der man dynamisch Tabellen Zeilen hinzufügen und entfernen kann.

Hier mal ein Beispiel wie man eine Zeile hinzufügt:
*/

function addNewRow() {
	tableObj = document.getElementById('tableCol');
	// add new row at the end
	row = tableObj.insertRow(-1);
 
	var x=row.insertCell(0);
	x.innerHTML="cell1";
 
	var z=row.insertCell(1);
	z.innerHTML="cell2";
}

/*
Diese Funktion legt an der tabelle mit der ID "tableCol" eine Neue Reihe am Ende ( das -1 bei .insertRow ) an. Dies kann beliebig oft wiederholt werden.
*/