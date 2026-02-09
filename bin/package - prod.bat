@echo off
echo.
echo [信息] 打包Web工程，生成war/jar包文件。
echo.

%~d0
cd %~dp0

del D:\workspace\health\healthcare\BackendSystem\healthcare-admin\src\main\resources\application.yml

del D:\workspace\health\healthcare\BackendSystem\healthcare-admin\src\main\resources\application-druid.yml

copy D:\workspace\health\healthcare\BackendSystem\bin\config\application-prod.yml D:\workspace\health\healthcare\BackendSystem\healthcare-admin\src\main\resources\application.yml

copy D:\workspace\health\healthcare\BackendSystem\bin\config\application-druid-prod.yml D:\workspace\health\healthcare\BackendSystem\healthcare-admin\src\main\resources\application-druid.yml

cd ..
call mvn clean package -Dmaven.test.skip=true

pause