# notes-sql / oracle

- [Herramienta de administración - SQL Developer](https://www.oracle.com/database/sqldeveloper/technologies/download/)
- [Documentación oficial 19c](https://docs.oracle.com/en/database/oracle/oracle-database/19/index.html)
- [Documentación oficial 21c](https://docs.oracle.com/en/database/oracle/oracle-database/21/index.html)

## Bases de Datos de Ejemplo

- [Oficiales](https://github.com/oracle-samples/db-sample-schemas/releases)
- [Genérica](https://github.com/lerocha/chinook-database)
- [Adicionales](https://dataedo.com/kb/databases/oracle/sample-databases)

## Net

- [Guía oficial](https://www.oracle.com/tools/technologies/quickstart-dotnet-for-oracle-database.html)
- [Recursos oficiales](https://www.oracle.com/database/technologies/net-downloads.html)
- [Ejemplos oficiales](https://github.com/oracle/dotnet-db-samples)
- Programación
  - [Tipos de datos](https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/Data-Types.html)
  - [Mapeo de tipos de datos con C#](https://docs.oracle.com/en/database/oracle/oracle-data-access-components/19.3/odpnt/entityEDMmapping.html)
- Nuget Packages
  - [ADO](https://www.nuget.org/packages/Oracle.ManagedDataAccess.Core)
  - [Entity Framework](https://www.nuget.org/packages/Oracle.EntityFrameworkCore)
- Extensiones
  - [VS 2022](https://marketplace.visualstudio.com/items?itemName=OracleCorporation.OracleDeveloperToolsForVisualStudio2022)
  - [VS Code](https://marketplace.visualstudio.com/items?itemName=Oracle.oracledevtools)

## Docker

- [Guía oficial](https://github.com/oracle/docker-images/blob/main/OracleDatabase/SingleInstance/README.md)
- [Imágenes](https://container-registry.oracle.com)

### Ejecutar contenedor

Obtener imagen

- Autenticar en la página <https://container-registry.oracle.com/ords/ocr/ba/database/enterprise> y generar un Auth Token (opción en el combobox del correo).

```powershell
# autenticar registro, username = correo del Oracle Account, password = Auth Token
docker login container-registry.oracle.com
# descargar imagen
docker pull container-registry.oracle.com/database/enterprise:19.3.0.0
```

Ejecutar imagen

```powershell
# crear carpeta de datos
New-Item -ItemType Directory -Force -Path "C:\Docker"
docker volume create "db-demo-oracle-data" --opt o=bind --opt type=none --opt device="C:\Docker\db-demo-oracle-data"
# ejecutar contenedor para 19c
docker run --name "db-demo-oracle" -p 1521:1521 -p 5500:5500 -e ORACLE_SID=ORCLSID -e ORACLE_PDB=ORCLPDB -e ORACLE_PWD=DEMO123* -e ORACLE_EDITION=enterprise -e INIT_SGA_SIZE=3096 -e INIT_PGA_SIZE=1024 -v "db-demo-oracle-data:/opt/oracle/oradata" -d "container-registry.oracle.com/database/enterprise:19.3.0.0"
# monitorear contenedor
docker logs "db-demo-oracle" --follow
```

### Conectar por herramienta

```txt
Host: localhost
Port: 1521
Database: ORCLPDB
Username: sys
Password: DEMO123*
Role: SYSDBA
```

### Conectar por bash

```powershell
# conectar a bash de contenedor
docker exec -it "db-demo-oracle" /bin/bash
# conectar con administrador de servidor
sqlplus sys/DEMO123*@//localhost:1521/ORCLPDB AS SYSDBA
# conectar con administrador de pdb
sqlplus pdbadmin/DEMO123*@//localhost:1521/ORCLPDB
```

### Ejecutar script

```powershell
$container='db-demo-oracle'
$connection_sys='sys/DEMO123*@//localhost:1521/ORCLPDB AS SYSDBA'
Get-Content "C:\\...\script.sql" | docker exec -i $container sqlplus $connection_sys
```

### Base de datos Chinook

```powershell
$container='db-demo-oracle'
$connection_sys='sys/DEMO123*@//localhost:1521/ORCLPDB AS SYSDBA'
Get-Content ".\examples\chinook\oracle_1_user.sql" | docker exec -i $container sqlplus $connection_sys
Get-Content ".\examples\chinook\oracle_2_tables.sql" | docker exec -i $container sqlplus $connection_sys
Get-Content ".\examples\chinook\oracle_3_data.sql" | docker exec -i $container sqlplus $connection_sys
Get-Content ".\examples\chinook\oracle_4_data.sql" | docker exec -i $container sqlplus $connection_sys
Get-Content ".\examples\chinook\oracle_5_data.sql" | docker exec -i $container sqlplus $connection_sys
Get-Content ".\examples\chinook\oracle_6_identities.sql" | docker exec -i $container sqlplus $connection_sys
```

## Comandos

```sql
-- terminar conexiones de usuarios
BEGIN
 FOR t IN (SELECT sid, serial#, status, username FROM v$session WHERE USERNAME IS NOT NULL AND USERNAME != 'SYS')
 LOOP
  EXECUTE IMMEDIATE 'ALTER SYSTEM KILL SESSION ''' || t.sid  || ',' || t.serial# || ''' IMMEDIATE';
  DBMS_OUTPUT.PUT_LINE('KILL ' || t.sid  || ',' || t.serial#);
 END LOOP;
END;
```
