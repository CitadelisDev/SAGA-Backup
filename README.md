# SAGA Backup – Script automat pentru arhivarea bazei de date

Acest repository conține un script batch (.cmd) care automatizează procesul de backup pentru aplicația SAGA C, incluzând:

- oprirea serviciilor necesare
- închiderea sesiunilor active
- generarea unei arhive 7z cu număr de versiune, dată și oră
- repornirea serviciului Firebird

Scriptul este util pentru administratori sau utilizatori care doresc o metodă rapidă și sigură de a crea copii de siguranță ale datelor SAGA.

## Funcționalități principale

- Solicită utilizatorului numărul versiunii (ex: 593)
- Preia automat data și ora sistemului
- Oprește serviciul FirebirdServerFirebird30_Saga
- Închide procesele sc.exe pentru a preveni blocaje
- Creează o arhivă .7z cu nume complet automatizat:

Backup-SagaC_V_<versiune>_<YYYY-MM-DD>_<HH>h<MM>.7z

- Salvează arhiva în directorul configurat
- Reporneste serviciul Firebird după finalizare

## Cerințe

Pentru funcționarea corectă a scriptului:

- Windows (7/10/11/Server)
- Drepturi de administrator
- 7-Zip sau 7za.exe disponibil în PATH sau în același folder cu scriptul
- Serviciul Firebird instalat sub numele:
  FirebirdServerFirebird30_Saga

## Configurare

În script există o variabilă care definește locația unde se salvează arhivele:

set "dest=D:\#Arhive Saga"

Modifică această cale după preferințe.

## Utilizare

1. Rulează scriptul prin dublu-click sau din Command Prompt.
2. Introdu numărul versiunii atunci când este solicitat:
   Introdu numarul versiunii (ex: 593):
3. Scriptul va:
   - verifica drepturile de administrator
   - opri serviciile necesare
   - crea arhiva
   - reporni serviciul Firebird
4. Arhiva finală va fi disponibilă în folderul configurat.

## Exemplu de arhivă generată

Backup-SagaC_V_593_2026-03-03_09h15.7z

## Codul scriptului

@echo off
:: === Cerere număr versiune ===
set /p ver="Introdu numarul versiunii (ex: 593): "

:: Formatare data timp
set "HR=%Time:~0,2%"
set "HR=%HR: =0%"
set "MIN=%Time:~3,2%"
set "data=%Date:~6,4%-%Date:~3,2%-%Date:~0,2%"
set "dest=D:\#Arhive Saga"

:: Inchidere sesiuni saga deschise si serviciu firebird
net session >nul 2>&1 || (
  powershell -c "Start-Process '%~f0' -Verb RunAs"
  exit /b
)

pushd "%~dp0%"
taskkill.exe /T /F /IM sc.exe
net stop FirebirdServerFirebird30_Saga

:: Arhivare
echo.
echo ==============================
echo   Creare arhiva in curs...
echo   Nume: Backup-SagaC_V_%ver%_%data%_%HR%h%MIN%.7z
echo ==============================
echo.

7za a -mx=1 -r "%dest%\Backup-SagaC_V_%ver%_%data%_%HR%h%MIN%.7z" "%cd%\*"

:: Pornire serviciu firebird
net start FirebirdServerFirebird30_Saga




