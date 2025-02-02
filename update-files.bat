@echo off
:: Allows for Terminal Colors to be used
set col=lib\cmdcolor.exe
set md5hash=c98b0e4152d3b02fbfb9f62581abada5

:: Display Banner
echo \033[91m======================== | %col%
echo \033[91m NetherSX2 Updater v1.6  | %col%
echo \033[91m======================== | %col%

:: Check if the NetherSX2 APK exists and if it's named 
if not exist 15210-v1.5-4248-noads.apk goto nofile
:: Check if the NetherSX2 APK isn't just a renamed AetherSX2 4248 APK
for /f %%f in ('""lib\md5sum.exe" "15210-v1.5-4248-noads.apk""') do (
  if %%f equ %md5hash% goto nofile
)

:: Updates to Latest GameDB with features removed that are not supported by the libemucore.so from March 13th
<nul set /p "=\033[96mUpdating the \033[91mGameDB...                 " | %col%
lib\aapt r 15210-v1.5-4248-noads.apk assets/GameIndex.yaml
lib\aapt a 15210-v1.5-4248-noads.apk assets/GameIndex.yaml  > nul
echo \033[92m[Done] | %col%

:: Updates the Controller Database
<nul set /p "=\033[96mUpdating the \033[91mController Database...    " | %col%
lib\aapt r 15210-v1.5-4248-noads.apk assets/game_controller_db.txt
lib\aapt a 15210-v1.5-4248-noads.apk assets/game_controller_db.txt  > nul
echo \033[92m[Done] | %col%

:: Updates the Widescreen Patches
<nul set /p "=\033[96mUpdating the \033[91mWidescreen Patches...     " | %col%
lib\aapt r 15210-v1.5-4248-noads.apk assets/cheats_ws.zip
lib\aapt a 15210-v1.5-4248-noads.apk assets/cheats_ws.zip  > nul
echo \033[92m[Done] | %col%

:: Updates the No-Interlacing Patches
<nul set /p "=\033[96mUpdating the \033[91mNo-Interlacing Patches... " | %col%
lib\aapt r 15210-v1.5-4248-noads.apk assets/cheats_ni.zip
lib\aapt a 15210-v1.5-4248-noads.apk assets/cheats_ni.zip  > nul
echo \033[92m[Done] | %col%

:: Resigns the APK before exiting
<nul set /p "=\033[96mResigning the \033[91mNetherSX2 APK...         " | %col%
java -jar lib\apksigner.jar sign --ks lib\android.jks --ks-pass pass:android 15210-v1.5-4248-noads.apk
:: Alternate Key:
:: java -jar lib\apksigner.jar sign --ks lib\public.jks --ks-pass pass:public 15210-v1.5-4248-noads.apk
echo \033[92m[Done] | %col%
goto end

:nofile
echo \033[31mError: No APK found or wrong one provided! | %col%
echo \033[31mPlease provide a copy of NetherSX2 named 15210-v1.5-4248-noads.apk! | %col%
goto end

:end
pause