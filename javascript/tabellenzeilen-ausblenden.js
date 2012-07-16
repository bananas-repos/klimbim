/* 
Wenn man dynamisch mit Javascript Tabellenzeilen ein und ausblenden will sollte man dies wie folgt tun:
*/

// ausblenden
document.getElementById('row_1').style.display = 'none';
 
// anzeigen
document.getElementById('row_1').style.display = '';

/*
Wie man sieht wird einfach die display Eigenschaft verändert. Das besondere dabei ist, dass zum Anzeigen die Eigenschaft leer gesetzt wird und damit dem Browser überlassen wird was er nimmt.
*/