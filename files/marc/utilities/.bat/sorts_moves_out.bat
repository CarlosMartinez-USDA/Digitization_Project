@echo off
rem For each file in your folder
for %%a in (".\*") do (
    rem check if the file has an extension and if it is not our script
    if "%%~xa" NEQ ""  if "%%~dpxa" NEQ "%~dpx0" ( >>STOUT.txt
        rem check if extension folder exists, if not it is created
        if not exist "%%~xa" mkdir "%%~xa"
        rem Copy (or change to move) the file to directory
        move "%%a" "%%~dpa%%~xa\" 
    )
)