@echo off
setlocal
echo.
echo "OK Ned, so you wanna create a Deployment Marker in New Relic..."
echo "Notes: Press Enter to leave blank or use default."
echo "       Fields marked (opt.) are optional."
echo.
set /p nrapikey= "What is the API key? [default: API key for XOC] "
set /p nrappname= "What is the app name? [default: FFM ROLLUP APP] "
set /p nruser= "Who is the submitting user? [default: Ned Hammond] "
set /p nrrevision= "(opt.) What is the revision #?  [default: none] "
set /p nrdescription= "(opt.) What is the summary description? [default: none] "
set /p nrchangelog= "(opt.) What is the detailed description? [default: none] "

set nrurl=https://rpm.newrelic.com/deployments.xml
set curlloc=%CD%\curl-7.33.0-win32\bin

if "%nrapikey%" == "" set nrapikey=41a852b2bf0d96c05568c91b87b5c005f80c0aad72cbb47
if "%nrappname%" == "" set nrappname=FFM ROLLUP APP
if "%nruser%" == "" set nruser=Ned Hammond
set curlstring=-H "x-api-key:%nrapikey%" -d "deployment[app_name]=%nrappname%" -d "deployment[user]=%nruser%"

if "%nrrevision%" NEQ "" set curlstring=%curlstring% -d "deployment[revision]=%nrrevision%"
if "%nrdescription%" NEQ "" set curlstring=%curlstring% -d "deployment[description]=%nrdescription%"
if "%nrchangelog%" NEQ "" set curlstring=%curlstring% -d "deployment[changelog]=%nrchangelog%"
set curlstring=%curlstring% %nrurl%

echo.
echo Executing: curl %curlstring%
echo.
"%curlloc%\curl.exe" %curlstring%
echo.
echo Done! 

