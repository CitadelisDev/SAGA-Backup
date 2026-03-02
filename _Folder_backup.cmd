@echo off
:: === Cerere număr versiune ===
set /p ver="Introdu numarul versiunii (ex: 593): "

::Formatare data timp (daca aveti data dd/MM/YYYY) si parametrii 
set "HR=%Time:~0,2%"
set "HR=%HR: =0%"
set "MIN=%Time:~3,2%"
set "data=%Date:~6,4%-%Date:~3,2%-%Date:~0,2%
set "dest=D:\#Arhive Saga"
::Inchidere sesiuni saga deschise si serviciu firebird
net session >nul 2>&1 || (
  powershell -c "Start-Process '%~f0' -Verb RunAs"
  exit /b
)
pushd %~dp0%
taskkill.exe /T /F /IM sc.exe
net stop FirebirdServerFirebird30_Saga
::Arhivare
:: === Creare arhivă cu versiune și progres ===
echo.
echo ==============================
echo   Creare arhiva in curs...
echo   Nume: Backup-SagaC_V_%ver%_%data%_%HR%h%MIN%.7z
echo ==============================
echo.
7za a -mx=1 -r "%dest%\Backup-SagaC_V_%ver%_%data%_%HR%h%MIN%.7z" "%cd%\*"
::Porinire serviciu firebirdsaga
net start FirebirdServerFirebird30_Saga