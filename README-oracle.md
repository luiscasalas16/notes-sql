# notes-sql / oracle

- [Herramienta de administración - SQL Developer](https://www.oracle.com/database/sqldeveloper/technologies/download/)

## Bases de Datos de Ejemplo

- [Oficiales](https://github.com/oracle-samples/db-sample-schemas/releases)
- [Genérica](https://github.com/lerocha/chinook-database)
- [Adicionales](https://dataedo.com/kb/databases/oracle/sample-databases)

## TODO

https://github.com/steveswinsburg/oracle19c-docker
https://github.com/oracle/docker-images/blob/main/OracleDatabase/SingleInstance/README.md
https://docs.oracle.com/en/database/oracle/oracle-database/19/index.html

https://www.oracle.com/database/technologies/oracle19c-linux-downloads.html
LINUX.X64_193000_db_home.zip
git clone https://github.com/oracle/docker-images.git
cd \docker-images\OracleDatabase\SingleInstance\dockerfiles\19.3.0
docker build -t oracle/database:19.3.0-EE --build-arg DB_EDITION=EE .

docker run --name "oracle19.3" -p 1521:1521 -p 5500:5500 -e ORACLE_SID=orasid -e ORACLE_PDB=orapdb -e ORACLE_PWD=orapwd -v /opt/oracle/oradata -d oracle/database:19.3.0-EE
docker logs oracle19.3 --follow

conect
database: orapdb
user name: sys
password: orapwd
rol: sysdba

# contectar a bash de contenedor

docker exec -it oracle19.3 /bin/bash

# contectar con administrador de servidor

sqlplus sys/orapwd@//localhost:1521/orapdb as sysdba

# contectar con administrador de pdb

sqlplus pdbadmin/orapwd@//localhost:1521/orapdb

-- Create a user
CREATE USER developer IDENTIFIED BY developer;
--Grant permissions
GRANT CONNECT, RESOURCE TO developer;

docker container start oracle19.3
docker container stop oracle19.3

mkdir C:\docker
docker image save -o "C:\docker\oracle-database-19.3.0-EE.tar" "oracle/database:19.3.0-EE"
docker load -i "C:\docker\oracle-database-19.3.0-EE.tar"

$container='oracle19.3'
$connection_sys='sys/orapwd@//localhost:1521/orapdb as sysdba'
Get-Content Script.sql | docker exec -i $container sqlplus $connection_sys
