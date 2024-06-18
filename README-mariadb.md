# notes-sql / mariadb

- [Documentación oficial](https://mariadb.com/kb/en/documentation/)

## Bases de Datos de Ejemplo

- [Genérica](https://github.com/lerocha/chinook-database)

## Net

- [Guía oficial](https://mysqlconnector.net)
- Nuget Packages
  - [ADO](https://www.nuget.org/packages/MySqlConnector)
  - [Entity Framework](https://www.nuget.org/packages/Pomelo.EntityFrameworkCore.MySql)

## Docker

- [Imágenes](https://hub.docker.com/_/mariadb)

### Ejecutar imagen

```powershell
# crear carpeta de datos
New-Item -ItemType Directory -Force -Path "$HOME\.db-demo\db-demo-mariadb-data"
docker volume create "db-demo-mariadb-data" --opt o=bind --opt type=none --opt device="$HOME\.demo\db-demo-mariadb-data"
# ejecutar contenedor
docker run --name "db-demo-mariadb" -p 3306:3306 -e "MARIADB_USER=mariadb" -e "MARIADB_PASSWORD=DEMO123*" -e "MARIADB_ROOT_PASSWORD=DEMO123*" -v "db-demo-mariadb-data:/var/lib/mysql" -d "mariadb:11.4.2"
# monitorear contenedor
docker logs "db-demo-mariadb" --follow
```

### Conectar por herramienta

```txt
Hostname: localhost
Port: 3306
Username: root
Password: DEMO123*
```

### Conectar por bash

```powershell
# conectar a bash de contenedor
docker exec -it "db-demo-mariadb" /bin/bash
# conectar con administrador
mariadb --user=root --password=DEMO123*
```

### Ejecutar script

```powershell
$container='db-demo-mariadb'
$connection_user='root'
$connection_password='DEMO123*'
Get-Content "C:\\...\script.sql" | docker exec -i $container mariadb --user=$connection_user --password=$connection_password
```

### Base de datos Chinook

```powershell
$container='db-demo-mariadb'
$connection_user='root'
$connection_password='DEMO123*'
Get-Content ".\examples\chinook\mariadb.sql" | docker exec -i $container mariadb --user=$connection_user --password=$connection_password
```
