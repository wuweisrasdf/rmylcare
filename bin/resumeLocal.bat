@echo off


del D:\workspace\health\healthcare\BackendSystem\healthcare-admin\src\main\resources\application.yml

del D:\workspace\health\healthcare\BackendSystem\healthcare-admin\src\main\resources\application-druid.yml

copy D:\workspace\health\healthcare\BackendSystem\bin\config\application-local.yml D:\workspace\health\healthcare\BackendSystem\healthcare-admin\src\main\resources\application.yml

copy D:\workspace\health\healthcare\BackendSystem\bin\config\application-druid-local.yml D:\workspace\health\healthcare\BackendSystem\healthcare-admin\src\main\resources\application-druid.yml

pause