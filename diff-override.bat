@echo off
REM echo 0 %0
REM echo 1 %1
REM echo 2 %2
REM echo 3 %3
REM echo 4 %4
REM echo 5 %5
REM echo 6 %6
REM echo 7 %7
REM echo 8 %8
REM echo 9 %9
REM echo 10 %10
REM echo 11 %11 
REM echo 12 %12
REM echo 13 %13
"C:\Program Files (x86)\Beyond Compare 3\BComp.exe" %6 %7 /leftreadonly 

REM Including the titles causes BC to return exit code 13, which causes svn to abort further diffs.
REM /title1=%3 /title2=%5
