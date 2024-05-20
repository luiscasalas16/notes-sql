# notes-sql / mssql

- [Herramienta de administración - SQL Server Management Studio](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms)
- [Versiones](https://sqlserverbuilds.blogspot.com)

## Bases de Datos de Ejemplo

- Oficiales
  - Wide World Importers
    - [Release](https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0)
    - [Modelo](https://dataedo.com/samples/html/WideWorldImporters)
  - Adventure Works
    - [Release](https://github.com/Microsoft/sql-server-samples/releases/tag/adventureworks)
    - [Modelo](https://dataedo.com/samples/html/AdventureWorks/)
- [Genérica](https://github.com/lerocha/chinook-database)
- [Adicionales](https://dataedo.com/kb/databases/sql-server/sample-databases)

## Docker

- [Guía oficial rápida](https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker)
- [Guía oficial completa](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-deployment)
- [Imágenes](https://hub.docker.com/_/microsoft-mssql-server)

Ejecutar imagen:

```powershell
# crear carpeta de datos
New-Item -ItemType Directory -Force -Path "$HOME\.demo\mssql-demo-data"
docker volume create "mssql-demo-data" --opt o=bind --opt type=none --opt device="$HOME\.demo\mssql-demo-data"
docker volume create "mssql-demo-log" --opt o=bind --opt type=none --opt device="$HOME\.demo\mssql-demo-log"
docker volume create "mssql-demo-secrets" --opt o=bind --opt type=none --opt device="$HOME\.demo\mssql-demo-secrets"
# ejecutar contenedor
docker run --name "mssql-demo" -p 1433:1433 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=DEMO123*" -v "mssql-demo-data:/var/opt/mssql/data" -v "mssql-demo-log:/var/opt/mssql/log" -v "mssql-demo-secrets:/var/opt/mssql/secrets" -d "mcr.microsoft.com/mssql/server:2022-CU12-ubuntu-22.04"
# monitorear contenedor
docker logs "mssql-demo" --follow
```

- Conectar por herramienta

```txt
Hostname: localhost
Port: 1433
Username: sa
Password: DEMO123*
```

- Conectar por bash

```powershell
# conectar a bash de contenedor
docker exec -it "mssql-demo" /bin/bash
# conectar con administrador
/opt/mssql-tools/bin/sqlcmd -S localhost -U 'sa' -P 'DEMO123*'
```

- Ejecutar script

```powershell
$container='mssql-demo'
$connection_user='sa'
$connection_password='DEMO123*'
Get-Content ".\examples\Chinook_SqlServer.sql" | docker exec -i $container /opt/mssql-tools/bin/sqlcmd -S localhost -U $connection_user -P $connection_password
```
