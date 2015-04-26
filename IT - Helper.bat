::--------------------------------------------------------------------::
::                     Remote - IT Service Desk                       :: 
::--------------------------------------------------------------------::
:: Desenvolvido por André Abreu | IT Support Analyst                  ::
::                                                                    ::
:: E-mail: andreabreu.trp@aon.net / br.ars.suportesp03@aon.com        ::
::                                                                    ::
::--------------------------------------------------------------------::
::  Este programa é distribuído na esperança de que possa ser útil,   ::
::  mas SEM NENHUMA GARANTIA; sem uma garantia implícita de ADEQUAÇÃO ::
::  a qualquer MERCADO ou APLICAÇÃO EM PARTICULAR. Veja a             ::
::  Licença Pública Geral GNU para maiores detalhes.                  ::
::--------------------------------------------------------------------::

@echo off
color a
title Remote - IT Service Desk

::Checa privilegios administrativos
net session >nul 2>&1
    if %errorLevel% == 2 (
        color c
        echo.
        echo Falha: O programa requer privilegios administrativos.
        echo.
        echo.
        echo ----------------^>    Andre Abreu
        echo -----------------^>   IT Support Analyst
        echo.
        set /p session=Pressione qualquer tecla para sair. 
        exit
)
::FIM

:init
cls
echo.
set /p ip=IP: 

    for /F "tokens=1,2,3,4,5,6,7,8" %%A in ('"ping -a -n 1 %ip% -w 4l000| find "Disparando""') DO ( 
echo.
SET pc=%%B  
:menu
echo.
echo         /------------------------------------------\
echo         ^|          Remote - IT Service Desk        ^|
echo         ^|------------------------------------------^|
echo         ^|               %%B              
echo %%B | clip
)

::Inicia Menu
echo 	^|------------------------------------------^|
echo 	^|                    ^|                     ^|
echo 	^| 1. Remote SCCM     ^| 4. Remote Explorer  ^|
echo 	^|                    ^|                     ^|
echo 	^| 2- Remote VNC      ^| 5. Remote Info      ^|
echo 	^|                    ^|                     ^|
echo 	^| 3) Remote Desktop  ^| 6. Remote Softwares ^|
echo 	^|                    ^|                     ^|
echo 	\------------------------------------------/ 

echo.
set /p choice=Escolha um numero: 
    if '%choice%'==' ' goto init
    if '%choice%'=='1' goto sccm
    if '%choice%'=='2' goto vnc
    if '%choice%'=='3' goto dsktp
    if '%choice%'=='4' goto explorer
    if '%choice%'=='5' goto info
    if '%choice%'=='6' goto soft
    if '%choice%'=='0' exit
    if '%choice%'=='c' goto init
echo.

:start

::-------------------------------------------------------------------------
::-------------------------- Remote SCCM --------------------------------
:sccm
	
	"C:\Program Files (x86)\Microsoft Configuration Manager Console\AdminUI\bin\i386\rc.exe" 1 %pc%

::-------------------------- Remote SCCM --------------------------------
cls
goto init

::-------------------------------------------------------------------------
::-------------------------- Remote VNC ---------------------------------
:vnc

	"c:\Program Files\UltraVNC\vncviewer.exe" -connect %ip%:1494

::-------------------------- Remote VNC ---------------------------------
cls
goto init

::-------------------------------------------------------------------------
::-------------------------- Remote Desktop ----------------------------
:dsktp

	mstsc /v %ip%

echo Registro Homepage
::-------------------------- Remote Desktop---------------------------
cls 
goto init

::-------------------------------------------------------------------------
::-------------------------- Remote Explorer ---------------------------
:explorer

	start \\%ip%\c$

::-------------------------- Remote Explorer ---------------------------
cls 
goto init

::-------------------------------------------------------------------------
::-------------------------- Remote Info -----------------------
:info
 
    msinfo32 /computer %pc%

::-------------------------- Remote Info -----------------------
cls 
goto init

::-------------------------------------------------------------------------
::-------------------------- Remote Softwares -------------------------
:soft
set dir=%~dp0
:list
    IF EXIST "%dir%SoftwareList" (
    set /p ip=
    wmic /node:"%ip%" /output:'%dir%SoftwareList\%ip%.html' product get name,version  /format:htable:"sortby=Name"
    start chrome "%dir%SoftwareList\%ip%.html"
) else (
    mkdir "%dir%SoftwareList"
    goto list
)
	
::-------------------------- Remote Softwares ---------------------------
cls 
goto init

::Desenvolvido por André Abreu | Service Desk 
:: --> Ramal 4477 
:: --> E-mail: br.ars.suportesp03@aon.com
