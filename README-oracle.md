# notes-sql / oracle

- [Herramienta de administración - SQL Developer](https://www.oracle.com/database/sqldeveloper/technologies/download/)
- [Documentación oficial](https://docs.oracle.com/en/database/oracle/oracle-database/19/index.html)

## Bases de Datos de Ejemplo

- [Oficiales](https://github.com/oracle-samples/db-sample-schemas/releases)
- [Genérica](https://github.com/lerocha/chinook-database)
- [Adicionales](https://dataedo.com/kb/databases/oracle/sample-databases)

## Docker

- [Guía oficial](https://github.com/oracle/docker-images/blob/main/OracleDatabase/SingleInstance/README.md)
- [Guía adicional](https://github.com/steveswinsburg/oracle19c-docker)

Construir imagen:

```powershell
# clonar repositorio
git clone "https://github.com/oracle/docker-images.git"
# navegar a directorio
cd \docker-images\OracleDatabase\SingleInstance\dockerfiles\19.3.0
# descargar LINUX.X64_193000_db_home.zip
Start-Process "https://www.oracle.com/database/technologies/oracle19c-linux-downloads.html"
# navegar a directorio
cd \docker-images\OracleDatabase\SingleInstance\dockerfiles
# ejecutar construcción de imagen
wsl -e ./buildContainerImage.sh -v 19.3.0 -t oracle-database-19.3.0-ee -e
```

Ejecutar imagen:

```powershell
# crear carpeta de datos
New-Item -ItemType Directory -Force -Path "$HOME\.demo\oracle-demo-data"
docker volume create "oracle-demo-data" --opt o=bind --opt type=none --opt device="$HOME\.demo\oracle-demo-data"
# ejecutar imagen
docker run --name "oracle-demo" -p 1521:1521 -p 5500:5500 -e ORACLE_SID=ORCLSID -e ORACLE_PDB=ORCLPDB -e ORACLE_PWD=DEMO123* -e INIT_SGA_SIZE=3096 -e INIT_PGA_SIZE=1024 -v "oracle-demo-data:/opt/oracle/oradata" -d "oracle-database-19.3.0-ee"
# esperar a que finalice el proceso
docker logs "oracle-demo" --follow
```

- Conectar por herramienta

Hostname: localhost
Port: 1521
Service Name: ORCLPDB
Username: sys
Password: ORCLPWD
Role: AS SYSDBA

- Conectar por bash

```powershell
# conectar a bash de contenedor
docker exec -it "oracle-demo" /bin/bash
# conectar con administrador de servidor
sqlplus sys/ORCLPWD@//localhost:1521/ORCLPDB AS SYSDBA
# conectar con administrador de pdb
sqlplus pdbadmin/ORCLPWD@//localhost:1521/ORCLPDB
```

- Crear usuario

```sql
-- Create a user
CREATE USER developer IDENTIFIED BY developer;
--Grant permissions
GRANT CONNECT, RESOURCE TO developer;
```

- Ejecutar script

```powershell
$container='"oracle-demo"'
$connection_sys='sys/ORCLPWD@//localhost:1521/ORCLPDB AS SYSDBA'
Get-Content Script.sql | docker exec -i $container sqlplus $connection_sys
```
