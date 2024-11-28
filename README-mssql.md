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

## Net

## Docker

- [Guía oficial rápida](https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker)
- [Guía oficial completa](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-deployment)
- [Imágenes](https://hub.docker.com/_/microsoft-mssql-server)

### Ejecutar contenedor

```powershell
# crear carpetas de datos
New-Item -ItemType Directory -Force -Path "C:\Docker"
docker volume create "db-demo-mssql-data" --opt o=bind --opt type=none --opt device="C:\Docker\db-demo-mssql-data"
docker volume create "db-demo-mssql-log" --opt o=bind --opt type=none --opt device="C:\Docker\db-demo-mssql-log"
docker volume create "db-demo-mssql-secrets" --opt o=bind --opt type=none --opt device="C:\Docker\db-demo-mssql-secrets"
# ejecutar contenedor
docker run --name "db-demo-mssql" -p 1433:1433 -p 135:135 -p 51000:51000 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=DEMO123*" -e 'MSSQL_RPC_PORT=135' -e 'MSSQL_DTC_TCP_PORT=51000' -v "db-demo-mssql-data:/var/opt/mssql/data" -v "db-demo-mssql-log:/var/opt/mssql/log" -v "db-demo-mssql-secrets:/var/opt/mssql/secrets" -d "mcr.microsoft.com/mssql/server:2022-latest"
# monitorear contenedor
docker logs "db-demo-mssql" --follow
```

### Conectar por herramienta

```txt
Hostname: localhost
Port: 1433
Username: sa
Password: DEMO123*
```

### Conectar por bash

```powershell
# conectar a bash de contenedor
docker exec -it "db-demo-mssql" /bin/bash
# conectar con administrador
/opt/mssql-tools/bin/sqlcmd -S localhost -U 'sa' -P 'DEMO123*'
```

### Ejecutar script

```powershell
$container='db-demo-mssql'
$connection_user='sa'
$connection_password='DEMO123*'
Get-Content "C:\\...\script.sql" | docker exec -i $container /opt/mssql-tools/bin/sqlcmd -S localhost -U $connection_user -P $connection_password
```

### Base de datos Chinook

```powershell
$container='db-demo-mssql'
$connection_user='sa'
$connection_password='DEMO123*'
Get-Content ".\examples\chinook\mssql.sql" | docker exec -i $container /opt/mssql-tools/bin/sqlcmd -S localhost -U $connection_user -P $connection_password
```
