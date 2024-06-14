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
- Nuget Packages
  - [ADO](https://www.nuget.org/packages/Oracle.ManagedDataAccess.Core)
  - [Entity Framework](https://www.nuget.org/packages/Oracle.EntityFrameworkCore)
- Extensiones
  - [VS 2022](https://marketplace.visualstudio.com/items?itemName=OracleCorporation.OracleDeveloperToolsForVisualStudio2022)
  - [VS Code](https://marketplace.visualstudio.com/items?itemName=Oracle.oracledevtools)

## Docker

- [Guía oficial](https://github.com/oracle/docker-images/blob/main/OracleDatabase/SingleInstance/README.md)

### Construir imagen

```powershell
# clonar repositorio
git clone "https://github.com/oracle/docker-images.git"
# navegar a directorio
cd \docker-images\OracleDatabase\SingleInstance\dockerfiles\19.3.0
# descargar binario
Start-Process "https://www.oracle.com/database/technologies/oracle-database-software-downloads.html"
    # para 19c LINUX.X64_193000_db_home.zip en \OracleDatabase\SingleInstance\dockerfiles\19.3.0
    # para 21c LINUX.X64_213000_db_home.zip en \OracleDatabase\SingleInstance\dockerfiles\21.3.0
# navegar a directorio
cd \docker-images\OracleDatabase\SingleInstance\dockerfiles
# ejecutar construcción de imagen
    # para 19c
    wsl -e ./buildContainerImage.sh -v 19.3.0 -t oracle-database-19.3.0-ee -e
    # para 21c
    wsl -e ./buildContainerImage.sh -v 21.3.0 -t oracle-database-21.3.0-ee -e
```

### Ejecutar imagen

```powershell
# crear carpeta de datos
New-Item -ItemType Directory -Force -Path "$HOME\.demo\oracle-demo-data"
docker volume create "oracle-demo-data" --opt o=bind --opt type=none --opt device="$HOME\.demo\oracle-demo-data"
# ejecutar contenedor
    # para 19c
    docker run --name "oracle-demo" -p 1521:1521 -p 5500:5500 -e ORACLE_SID=ORCLSID -e ORACLE_PDB=ORCLPDB -e ORACLE_PWD=DEMO123* -e ORACLE_EDITION=enterprise -e INIT_SGA_SIZE=3096 -e INIT_PGA_SIZE=1024 -v "oracle-demo-data:/opt/oracle/oradata" -d "oracle-database-19.3.0-ee"
    # para 21c
    docker run --name "oracle-demo" -p 1521:1521 -p 5500:5500 -e ORACLE_SID=ORCLSID -e ORACLE_PDB=ORCLPDB -e ORACLE_PWD=DEMO123* -e ORACLE_EDITION=enterprise -e INIT_SGA_SIZE=3096 -e INIT_PGA_SIZE=1024 -v "oracle-demo-data:/opt/oracle/oradata" -d "oracle-database-21.3.0-ee"
# monitorear contenedor
docker logs "oracle-demo" --follow
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
docker exec -it "oracle-demo" /bin/bash
# conectar con administrador de servidor
sqlplus sys/DEMO123*@//localhost:1521/ORCLPDB AS SYSDBA
# conectar con administrador de pdb
sqlplus pdbadmin/DEMO123*@//localhost:1521/ORCLPDB
```

### Ejecutar script

```powershell
$container='oracle-demo'
$connection_sys='sys/DEMO123*@//localhost:1521/ORCLPDB AS SYSDBA'
Get-Content ".\examples\Chinook_Oracle_0_User.sql" | docker exec -i $container sqlplus $connection_sys
Get-Content ".\examples\Chinook_Oracle_1_Tables.sql" | docker exec -i $container sqlplus $connection_sys
Get-Content ".\examples\Chinook_Oracle_2_Data.sql" | docker exec -i $container sqlplus $connection_sys
Get-Content ".\examples\Chinook_Oracle_3_Data.sql" | docker exec -i $container sqlplus $connection_sys
Get-Content ".\examples\Chinook_Oracle_4_Data.sql" | docker exec -i $container sqlplus $connection_sys
Get-Content ".\examples\Chinook_Oracle_5_Identities.sql" | docker exec -i $container sqlplus $connection_sys
```
