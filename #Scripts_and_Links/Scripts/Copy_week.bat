@echo off
chcp 65001
setlocal EnableDelayedExpansion
set CoutFile=C:\#Scripts_and_Links\Scripts\Counter.tmp
set htmlFile=C:\#Scripts_and_Links\Scripts\html.tmp
set HOMEFTP=D:\FTP
set TIMELINE7ZFOLDER=D:\TIMELINE_Archive
set TEMPTIMELINE7ZFOLDER=D:\TIMELINE_Archive\Temp
set GDrivefolder=D:\Google_Drive\JAM_Factory_Timeline_Archive
set /p Counter="" <"%CoutFile%"
set /a Counter=10!Counter! + 1
set Counter=!Counter:~-5!
set MailTo=johnniex568@gmail.com
rem Створюю папки камер якщо їх немає
if not exist !TIMELINE7ZFOLDER! md !TIMELINE7ZFOLDER!
if not exist !TIMELINE7ZFOLDER!\Camera_A md !TIMELINE7ZFOLDER!\Camera_A
if not exist !TIMELINE7ZFOLDER!\Camera_B md !TIMELINE7ZFOLDER!\Camera_B
if not exist !TIMELINE7ZFOLDER!\Camera_C md !TIMELINE7ZFOLDER!\Camera_C
if not exist !GDrivefolder!\Camera_A md !GDrivefolder!\Camera_A
if not exist !GDrivefolder!\Camera_B md !GDrivefolder!\Camera_B
if not exist !GDrivefolder!\Camera_C md !GDrivefolder!\Camera_C
Rem Програма 7-Zip існує?
If Exist "!ProgramFiles(x86)!\7-Zip\7z.exe" Set 7ZipProgram=!ProgramFiles(x86)!\7-Zip\7z.exe
If Exist "!ProgramFiles!\7-Zip\7z.exe" Set 7ZipProgram=!ProgramFiles!\7-Zip\7z.exe
If Not Exist "!7ZipProgram!" GoTo Exit







:Camera_A
rem Підраховую кількість файлів для архівації
Set CntFileCameraA=0
for /f "tokens=*" %%i in (' dir /b /s /a "!TEMPTIMELINE7ZFOLDER!\Camera_A\*.jpg" ') Do Set /A CntFileCameraA += 1
if !CntFileCameraA! == 0 GoTO NotCamera_A

Rem Архівую Camera_A
"!7ZipProgram!" a -t7z -m0=ppmd -mx=9 "!TIMELINE7ZFOLDER!\Camera_A\!Counter!_!date!_Camera_A.7z" "!TEMPTIMELINE7ZFOLDER!\Camera_A\*"
copy "!TIMELINE7ZFOLDER!\Camera_A\!Counter!_!date!_Camera_A.7z" "!GDrivefolder!\Camera_A"
rd /S /Q %TEMPTIMELINE7ZFOLDER%\Camera_A

Set CameraAStatus=Архів створено. Кількість доданих файлів !CntFileCameraA!.
Set /A CameraAStatusCode=0
GoTO Camera_B

:NotCamera_A
Set CameraAStatus=Архів не Створено! (Не підготовлені файли з FTP).
Set /A CameraAStatusCode=1
GoTO Camera_B







:Camera_B
rem Підраховую кількість файлів для архівації
Set CntFileCameraB=0
for /f "tokens=*" %%i in (' dir /b /s /a "!TEMPTIMELINE7ZFOLDER!\Camera_B\*.jpg" ') Do Set /A CntFileCameraB += 1
if !CntFileCameraB! == 0 GoTO NotCamera_B
Rem Архівую Camera_B
"!7ZipProgram!" a -t7z -m0=ppmd -mx=9 "!TIMELINE7ZFOLDER!\Camera_B\!Counter!_!date!_Camera_B.7z" "!TEMPTIMELINE7ZFOLDER!\Camera_B\*"
copy "!TIMELINE7ZFOLDER!\Camera_B\!Counter!_!date!_Camera_B.7z" "!GDrivefolder!\Camera_B"
rd /S /Q %TEMPTIMELINE7ZFOLDER%\Camera_B

Set CameraBStatus=Архів створено. Кількість доданих файлів !CntFileCameraB!.
Set /A CameraBStatusCode=0
GoTO Camera_C

:NotCamera_B
Set CameraBStatus=Архів не Створено! (Не підготовлені файли з FTP).
Set /A CameraBStatusCode=1
GoTO Camera_C



:Camera_C
rem Підраховую кількість файлів для архівації
Set CntFileCameraC=0
for /f "tokens=*" %%i in (' dir /b /s /a "!TEMPTIMELINE7ZFOLDER!\Camera_C\*.jpg" ') Do Set /A CntFileCameraC += 1
if !CntFileCameraC! == 0 GoTO NotCamera_C
Rem Архівую Camera_C
"!7ZipProgram!" a -t7z -m0=ppmd -mx=9 "!TIMELINE7ZFOLDER!\Camera_C\!Counter!_!date!_Camera_C.7z" "!TEMPTIMELINE7ZFOLDER!\Camera_C\*"
copy "!TIMELINE7ZFOLDER!\Camera_C\!Counter!_!date!_Camera_C.7z" "!GDrivefolder!\Camera_C"
rd /S /Q %TEMPTIMELINE7ZFOLDER%\Camera_C

Set CameraCStatus=Архів створено. Кількість доданих файлів !CntFileCameraC!.
Set /A CameraCStatusCode=0
GoTO EmailAlert

:NotCamera_C
Set CameraCStatus=Архів не Створено! (Не підготовлені файли з FTP).
Set /A CameraCStatusCode=1
GoTO EmailAlert


:EmailAlert
Set EmailSubject=Все Гаразд. З всіх 3-ох камер архіви зроблено!
Set /A SumStatusCode=%CameraAStatusCode%+%CameraBStatusCode%+%CameraCStatusCode%
if %SumStatusCode% == 1 Set EmailSubject=Увага. Лише з 2-ох камер архіви зроблено!
if %SumStatusCode% == 2 Set EmailSubject=Увага. Лише з 1-єї камери архів зроблено!
if %SumStatusCode% == 3 Set EmailSubject=Увага. Архіви не зроблено!!!

rem Будую html
if %SumStatusCode% == 1 echo ^<h3^>^<strong^>^<span style="color: #ff0000;"^>Увага. Лише з 2-ох камер архіви зроблено!^</strong^>^</h3^>>>"%htmlFile%"
if %SumStatusCode% == 2 echo ^<h3^>^<strong^>^<span style="color: #ff0000;"^>Увага. Лише з 1-єї камери архів зроблено!^</strong^>^</h3^>>>"%htmlFile%"
if %SumStatusCode% == 3 echo ^<h3^>^<strong^>^<span style="color: #ff0000;"^>Увага. Архіви не зроблено!!!^</strong^>^</h3^>>>"%htmlFile%"
if %SumStatusCode% == 0 echo ^<h3^>^<strong^>Все Гаразд. З всіх 3-ох камер архіви зроблено!^</strong^>^</h3^>>>"%htmlFile%"
echo ^<hr /^>>>"%htmlFile%"
echo ^<h4^>Статус кожної з камер:^</h4^>>>"%htmlFile%"
echo ^<ul^>>>"%htmlFile%"
if %CameraAStatusCode% == 0 echo ^<li^>^<strong^>Camera A:^&nbsp;^</strong^>^<em^>!CameraAStatus!^</em^>^</li^>>>"%htmlFile%"
if %CameraAStatusCode% == 1 echo ^<li^>^<strong^>Camera A:^&nbsp;^</strong^>^<span style="color: #ff0000;"^>^<em^>!CameraAStatus!^</em^>^</li^>>>"%htmlFile%"
if %CameraBStatusCode% == 0 echo ^<li^>^<strong^>Camera B:^&nbsp;^</strong^>^<em^>!CameraBStatus!^</em^>^</li^>>>"%htmlFile%"
if %CameraBStatusCode% == 1 echo ^<li^>^<strong^>Camera B:^&nbsp;^</strong^>^<span style="color: #ff0000;"^>^<em^>!CameraBStatus!^</em^>^</li^>>>"%htmlFile%"
if %CameraCStatusCode% == 0 echo ^<li^>^<strong^>Camera C:^&nbsp;^</strong^>^<em^>!CameraCStatus!^</em^>^</li^>>>"%htmlFile%"
if %CameraCStatusCode% == 1 echo ^<li^>^<strong^>Camera C:^&nbsp;^</strong^>^<span style="color: #ff0000;"^>^<em^>!CameraCStatus!^</em^>^</li^>>>"%htmlFile%"
echo ^</ul^>>>"%htmlFile%"
echo ^<p^>^&nbsp;^</p^>>>"%htmlFile%"
echo ^<p^>^&nbsp;^</p^>>>"%htmlFile%"
echo ^<p^>^&nbsp;^</p^>>>"%htmlFile%"
echo ^<p^>^&nbsp;^</p^>>>"%htmlFile%"
echo ^<p^>^&nbsp;^</p^>>>"%htmlFile%"
echo ^<p^>^&nbsp;^</p^>>>"%htmlFile%"
echo ^<p^>^&nbsp;^</p^>>>"%htmlFile%"
echo ^<p^>^&nbsp;^</p^>>>"%htmlFile%"
echo ^<hr /^>>>"%htmlFile%"
echo ^<p^>Виникли питання?^<em^>^<br /^>^</em^>^<strong^>Роман Перевізник^</strong^>^<br /^>^<em^>Телефон: ^<a href="tel:+380937047310"^>+380937047310^<br /^>^</a^>E-mail:^&nbsp;^<a href="mailto:romawkafor@gmail.com"^>romawkafor@gmail.com^<br /^>^</a^>^</em^>^<em^>Viber: +380937047310^</em^>^<br /^>^<em^>Telegram: @Roman_Pereviznyk^</em^>^</p^>>>"%htmlFile%"

rem Відправляю E-mail
mailalert  -r "%MailTo%" -s "%EmailSubject%" -b "@"%htmlFile%"" 
rem Видаляю html
del /F /Q "%htmlFile%"

rem Записую лічильник в файл
if %SumStatusCode% LEQ 2 del /F /Q "%CoutFile%"
if %SumStatusCode% LEQ 2 echo %Counter%>>"%CoutFile%"

exit