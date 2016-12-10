@ECHO OFF
SETLOCAL
:loop_start
ping www.google.com -n 1 > log.txt

REM If no line starting with Reply that mean ping is fail with some error
FINDSTR "Reply*" log.txt > log1.txt
IF NOT ERRORLEVEL 1 ( goto :test_latiency ) else ( goto :ping_fail)

:ping_fail
echo "%date% %time% :" >> ovde_sam_puko.log
type log.txt >> ovde_sam_puko.log
goto :loop_again

:test_latiency
set /p one_line=<log1.txt
SET "rez=%one_line:*time=%"
SET "rez=%rez:~1%"
SET "rez=%rez:ms=%"
FOR /f %%a in ("%rez%") do set rez=%%a
IF %rez% geq 128 (echo "%date% %time% %one_line%" >> ovde_sam_puko.log)
goto :loop_again

REM leave cpu do to something smart
:loop_again
timeout 5 > NUL
GOTO :loop_start