@echo off
chcp 65001
setlocal EnableDelayedExpansion
set HOMEFTP=D:\FTP
set TIMELINEFOLDER=D:\TIMELINE
set TIMELINE7ZFOLDER=D:\TIMELINE_Archive
set TEMPTIMELINE7ZFOLDER=D:\TIMELINE_Archive\Temp
set DailyCoutFile=C:\#Scripts_and_Links\Scripts\DailyCounter.tmp
set /p DailyCounter="" <"%DailyCoutFile%"
set /a DailyCounter=10!DailyCounter! + 1
set DailyCounter=!DailyCounter:~-5!



rem Створюю папки камер якщо їх немає
if not exist !TIMELINEFOLDER! md !TIMELINEFOLDER!
if not exist !TIMELINEFOLDER!\Camera_A md !TIMELINEFOLDER!\Camera_A
if not exist !TIMELINEFOLDER!\Camera_B md !TIMELINEFOLDER!\Camera_B
if not exist !TIMELINEFOLDER!\Camera_C md !TIMELINEFOLDER!\Camera_C
if not exist !TIMELINE7ZFOLDER! md !TIMELINE7ZFOLDER!
if not exist !TEMPTIMELINE7ZFOLDER! md !TEMPTIMELINE7ZFOLDER!
if not exist !TEMPTIMELINE7ZFOLDER!\Camera_A md !TEMPTIMELINE7ZFOLDER!\Camera_A
if not exist !TEMPTIMELINE7ZFOLDER!\Camera_B md !TEMPTIMELINE7ZFOLDER!\Camera_B
if not exist !TEMPTIMELINE7ZFOLDER!\Camera_C md !TEMPTIMELINE7ZFOLDER!\Camera_C


rem Шукаю, створюю папку, переміщаю з FTP в TimeLine Камеру A
for /f "tokens=*" %%i in (' dir /b /s /a "%HOMEFTP%\Camera_A\*.jpg" ') do (
call set temppach=%%~pi
call set folderYear=!temppach:~23,4!
call set folderMouns=!temppach:~28,2!
call set folderDay=!temppach:~31,2!
call set filename=!DailyCounter!_!temppach:~31,2!-!temppach:~28,2!-!temppach:~23,4!_!temppach:~42,2!-!temppach:~45,2!_Camera_A.jpg
if not exist !TIMELINEFOLDER!\Camera_A\!folderYear! md !TIMELINEFOLDER!\Camera_A\!folderYear!
if not exist !TIMELINEFOLDER!\Camera_A\!folderYear!\!folderMouns! md !TIMELINEFOLDER!\Camera_A\!folderYear!\!folderMouns!
if not exist !TIMELINEFOLDER!\Camera_A\!folderYear!\!folderMouns!\!folderDay! md !TIMELINEFOLDER!\Camera_A\!folderYear!\!folderMouns!\!folderDay!
if not exist !TEMPTIMELINE7ZFOLDER!\Camera_A\!folderYear! md !TEMPTIMELINE7ZFOLDER!\Camera_A\!folderYear!
if not exist !TEMPTIMELINE7ZFOLDER!\Camera_A\!folderYear!\!folderMouns! md !TEMPTIMELINE7ZFOLDER!\Camera_A\!folderYear!\!folderMouns!
if not exist !TEMPTIMELINE7ZFOLDER!\Camera_A\!folderYear!\!folderMouns!\!folderDay! md !TEMPTIMELINE7ZFOLDER!\Camera_A\!folderYear!\!folderMouns!\!folderDay!
copy %%i !TIMELINEFOLDER!\Camera_A\!folderYear!\!folderMouns!\!folderDay!\!filename!
copy %%i !TEMPTIMELINE7ZFOLDER!\Camera_A\!folderYear!\!folderMouns!\!folderDay!\!filename!
)

rem Шукаю, створюю папку, переміщаю з FTP в TimeLine Камеру B
for /f "tokens=*" %%i in (' dir /b /s /a "%HOMEFTP%\Camera_B\*.jpg" ') do (
call set temppach=%%~pi
call set folderYear=!temppach:~23,4!
call set folderMouns=!temppach:~28,2!
call set folderDay=!temppach:~31,2!
call set filename=!DailyCounter!_!temppach:~31,2!-!temppach:~28,2!-!temppach:~23,4!_!temppach:~42,2!-!temppach:~45,2!_Camera_B.jpg
if not exist !TIMELINEFOLDER!\Camera_B\!folderYear! md !TIMELINEFOLDER!\Camera_B\!folderYear!
if not exist !TIMELINEFOLDER!\Camera_B\!folderYear!\!folderMouns! md !TIMELINEFOLDER!\Camera_B\!folderYear!\!folderMouns!
if not exist !TIMELINEFOLDER!\Camera_B\!folderYear!\!folderMouns!\!folderDay! md !TIMELINEFOLDER!\Camera_B\!folderYear!\!folderMouns!\!folderDay!
if not exist !TEMPTIMELINE7ZFOLDER!\Camera_B\!folderYear! md !TEMPTIMELINE7ZFOLDER!\Camera_B\!folderYear!
if not exist !TEMPTIMELINE7ZFOLDER!\Camera_B\!folderYear!\!folderMouns! md !TEMPTIMELINE7ZFOLDER!\Camera_B\!folderYear!\!folderMouns!
if not exist !TEMPTIMELINE7ZFOLDER!\Camera_B\!folderYear!\!folderMouns!\!folderDay! md !TEMPTIMELINE7ZFOLDER!\Camera_B\!folderYear!\!folderMouns!\!folderDay!
copy %%i !TIMELINEFOLDER!\Camera_B\!folderYear!\!folderMouns!\!folderDay!\!filename!
copy %%i !TEMPTIMELINE7ZFOLDER!\Camera_B\!folderYear!\!folderMouns!\!folderDay!\!filename!
)

rem Шукаю, створюю папку, переміщаю з FTP в TimeLine Камеру C
for /f "tokens=*" %%i in (' dir /b /s /a "%HOMEFTP%\Camera_C\*.jpg" ') do (
call set temppach=%%~pi
call set folderYear=!temppach:~23,4!
call set folderMouns=!temppach:~28,2!
call set folderDay=!temppach:~31,2!
call set filename=!DailyCounter!_!temppach:~31,2!-!temppach:~28,2!-!temppach:~23,4!_!temppach:~42,2!-!temppach:~45,2!_Camera_C.jpg
if not exist !TIMELINEFOLDER!\Camera_C\!folderYear! md !TIMELINEFOLDER!\Camera_C\!folderYear!
if not exist !TIMELINEFOLDER!\Camera_C\!folderYear!\!folderMouns! md !TIMELINEFOLDER!\Camera_C\!folderYear!\!folderMouns!
if not exist !TIMELINEFOLDER!\Camera_C\!folderYear!\!folderMouns!\!folderDay! md !TIMELINEFOLDER!\Camera_C\!folderYear!\!folderMouns!\!folderDay!
if not exist !TEMPTIMELINE7ZFOLDER!\Camera_C\!folderYear! md !TEMPTIMELINE7ZFOLDER!\Camera_C\!folderYear!
if not exist !TEMPTIMELINE7ZFOLDER!\Camera_C\!folderYear!\!folderMouns! md !TEMPTIMELINE7ZFOLDER!\Camera_C\!folderYear!\!folderMouns!
if not exist !TEMPTIMELINE7ZFOLDER!\Camera_C\!folderYear!\!folderMouns!\!folderDay! md !TEMPTIMELINE7ZFOLDER!\Camera_C\!folderYear!\!folderMouns!\!folderDay!
copy %%i !TIMELINEFOLDER!\Camera_C\!folderYear!\!folderMouns!\!folderDay!\!filename!
copy %%i !TEMPTIMELINE7ZFOLDER!\Camera_C\!folderYear!\!folderMouns!\!folderDay!\!filename!
)


rem Видаляю папки та файли з FTP
rd /S /Q %HOMEFTP%\Camera_A\Camera_A
rd /S /Q %HOMEFTP%\Camera_B\Camera_B
rd /S /Q %HOMEFTP%\Camera_C\Camera_C



rem Записую лічильник в файл
del /F /Q "%DailyCoutFile%"
echo %DailyCounter%>>"%DailyCoutFile%"

exit