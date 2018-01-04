@ECHO OFF

goto :MAIN

:USAGE
    echo Usage: generate-dev-compose.bat /path/to/garlicoin
EXIT /B 0

:RESET_FILE
echo Reset file: %1
IF EXIST %1 DEL /F %1
EXIT /B 0


:GENERATE_COMPOSE
set fn=dev-compose.yml
CALL:RESET_FILE %fn%
echo version: "3" >> %fn%
echo services: >> %fn%
echo   development: >> %fn%
echo     build: development >> %fn%
echo     volumes: >> %fn%
echo       - %1:/garlicoin >> %fn%
echo     entrypoint: sh /entrypoint.sh >> %fn%
EXIT /B 0

:GENERATE_DOCKERFILE
set fn="development\Dockerfile"
CALL:RESET_FILE %fn%
echo FROM debian:stable-slim >> %fn%
echo[ >> %fn%
echo RUN useradd -r garlicoin    \\ >> %fn%
echo     ^&^& mkdir /garlicoin     \\ >> %fn%
echo     ^&^& apt-get update -y    \\ >> %fn%
echo     ^&^& apt-get install -y   \\ >> %fn%
echo         git                 \\ >> %fn%
echo         build-essential     \\ >> %fn%
echo         libtool             \\ >> %fn%
echo         autotools-dev       \\ >> %fn%
echo         automake            \\ >> %fn%
echo         pkg-config          \\ >> %fn%
echo         libssl-dev          \\ >> %fn%
echo         libevent-dev        \\ >> %fn%
echo         bsdmainutils        \\ >> %fn%
echo         libboost-all-dev    \\ >> %fn%
echo     ^&^& apt-get clean >> %fn%
echo COPY ./entrypoint.sh / >> %fn%
EXIT /B 0

:GENERATE_ENTRYPOINT
set fn="development\entrypoint.sh"
copy "release\entrypoint.sh" %fn%
EXIT /B 0

:GENERATE
MKDIR development
CALL:GENERATE_COMPOSE %1
CALL:GENERATE_DOCKERFILE
CALL:GENERATE_ENTRYPOINT
GOTO:EOF

:MAIN
IF "%1"=="" (call:USAGE)
IF NOT "%1"=="" (call:GENERATE %1)
EXIT /B 0
