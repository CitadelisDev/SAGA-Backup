SAGA Backup – Script automat pentru arhivarea bazei de date
Acest repository conține un script batch (.cmd) care automatizează procesul de backup pentru aplicația SAGA C, incluzând:

oprirea serviciilor necesare
închiderea sesiunilor active
generarea unei arhive 7z cu număr de versiune, dată și oră
repornirea serviciului Firebird

📌 Funcționalități principale
Solicită utilizatorului numărul versiunii (ex: 593)
Preia automat data și ora sistemului
Oprește serviciul FirebirdServerFirebird30_Saga
Închide procesele sc.exe pentru a preveni blocaje
Creează o arhivă .7z cu nume complet automatizat:
