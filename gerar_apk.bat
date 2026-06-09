@echo off
echo Iniciando a compilacao do App Financeiro...
call flutter build apk --release

echo.
echo Copiando o APK versionado para o Google Drive...
:: O asterisco (*.apk) garante que ele pegue o arquivo independentemente da versao no nome
copy /Y "build\app\outputs\apk\release\*.apk" "C:\Users\lucas\Documents\apps\"

echo.
echo Sucesso! O APK atualizado foi para o Drive.