@ECHO OFF
title Tresor - 1.0

:START
if EXIST "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" goto PASSWORDCHECKEXISTS
if NOT EXIST Tresor goto MDLOCKER

:PASSWORDCHECKEXISTS
if EXIST Tresorpassword.txt goto PASSWORD
if NOT EXIST Tresorpassword.txt goto PASSWORDCREATE

:PASSWORDCREATE
color c
cls
echo Bitte gebe ein Passwort ein.
echo.
set /p password="Passwort: "
echo %password% > Tresorpassword.txt
attrib +h +s Tresorpassword.txt
timeout 9>nul
exit

:PASSWORD
color a
echo Bitte gebe dein Passwort ein.
echo.
set /p pass="Passwort: "
for /f "Delims=" %%a in (Tresorpassword.txt) do (

set password=%%a

)

if %pass%==%password% goto AUSWAHL
goto FAIL

:AUSWAHL
color a
cls
echo 2) Passwort Verwalten.
echo 1) Tresor Oeffnen.
echo 0) Tresor Schliessen.
set /p cho1=">>>"
if %cho1%==2 goto PASSWORDVERWALTEN
if %cho1%==1 goto UNLOCK
if %cho1%==0 goto LOCK
echo Falsche Eingabe...
goto AUSWAHL

:PASSWORDVERWALTEN
color 4
cls
echo 2) Passwort Veraendern.
echo 1) Passwort Datei Anzeigen.
echo 0) Passwort Datei Verstecken.
set /p cho2=">>>"
if %cho2%==2 goto PWCHANGE
if %cho2%==1 goto PWUNHIDE
if %cho2%==0 goto PWHIDE

:PWCHANGE
color 4
cls
echo Bitte gebe dein neues Passwort ein.
set /p newpass="Passwort: "
echo %newpass% > Tresorpassword.txt

:PWHIDE
attrib +h +s Tresorpassword.txt
goto AUSWAHL

:PWUNHIDE
attrib -h -s Tresorpassword.txt
goto AUSWAHL

:LOCK
ren Tresor "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
attrib +h +s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
goto END

:UNLOCK
attrib -h -s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
ren "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" Tresor
goto END

:FAIL
cls
echo [!] Falsches Passwort
echo.
goto PASSWORDCHECKEXISTS

:MDLOCKER
md Tresor
goto PASSWORDCHECKEXISTS

:END
