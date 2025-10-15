# notes-sql / mssql

- Herramientas de administración
  - Management Studio
    - [Documentación](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms)
    - [Instalador v21](https://learn.microsoft.com/en-us/ssms/release-notes-21)
    - [Instalador v20](https://learn.microsoft.com/en-us/ssms/release-notes-20)
  - DBeaver
    - [Documentación](https://dbeaver.com/docs/dbeaver/)
    - [Instalador](https://dbeaver.io/download/)
- [Versiones](https://sqlserverbuilds.blogspot.com)

## Docker

- [Guía oficial rápida](https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-docker)
- [Guía oficial completa](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-deployment)
- [Docker Images](https://hub.docker.com/_/microsoft-mssql-server)

### Ejecutar

```powershell
New-Item -ItemType Directory -Force -Path "C:\Docker"

docker volume create "db-mssql-data" --opt o=bind --opt type=none --opt device="C:\Docker\db-mssql-data"
docker volume create "db-mssql-log" --opt o=bind --opt type=none --opt device="C:\Docker\db-mssql-log"
docker volume create "db-mssql-backup" --opt o=bind --opt type=none --opt device="C:\Docker\db-mssql-backup"
docker volume create "db-mssql-secrets" --opt o=bind --opt type=none --opt device="C:\Docker\db-mssql-secrets"

docker run --name "db-mssql" -p 1433:1433 -u 0:0 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=DEMO123*" -e "MSSQL_COLLATION=SQL_Latin1_General_CP1_CI_AI" -v "db-mssql-data:/var/opt/mssql/data" -v "db-mssql-log:/var/opt/mssql/log" -v "db-mssql-backup:/var/opt/mssql/backup" -v "db-mssql-secrets:/var/opt/mssql/secrets" -d "mcr.microsoft.com/mssql/server:2022-CU20-ubuntu-22.04"

docker logs "db-mssql" --follow
```

### Conectar

```txt
Hostname: localhost
Username: sa
Password: DEMO123*
```
Management Studio
<p align="center">
  <img src="./assets/mssql1.png" width="317.5"/>
</p>
DBeaver
<p align="center">
  <img src="./assets/mssql2.png" width="524"/>
</p>

### Conectar por bash

```powershell
docker exec -it "db-demo-mssql" /bin/bash

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

## Bases de Datos

- Oficiales
  - Adventure Works
    - [Release](https://github.com/Microsoft/sql-server-samples/releases/tag/adventureworks)
    - [Modelo](https://dataedo.com/samples/html/AdventureWorks/)
  - Wide World Importers
    - [Release](https://github.com/Microsoft/sql-server-samples/releases/tag/wide-world-importers-v1.0)
    - [Modelo](https://dataedo.com/samples/html/WideWorldImporters)
- [Genérica](https://github.com/lerocha/chinook-database)
- [Adicionales](https://dataedo.com/kb/databases/sql-server/sample-databases)

## Net
