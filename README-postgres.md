# notes-sql / postgres

- [Documentación oficial 16](https://www.postgresql.org/docs/16/index.html)

## Bases de Datos de Ejemplo

- [Genérica](https://github.com/lerocha/chinook-database)

## Net

- [Guía oficial](https://www.npgsql.org)
- Nuget Packages
  - [ADO](https://www.nuget.org/packages/Npgsql)
  - [Entity Framework](https://www.nuget.org/packages/Npgsql.EntityFrameworkCore.PostgreSQL)
- Extensiones
  - [VS 2022](https://marketplace.visualstudio.com/items?itemName=RojanskyS.NpgsqlPostgreSQLIntegration)
  - [VS Code](https://marketplace.visualstudio.com/items?itemName=ckolkman.vscode-postgres)

## Docker

- [Imágenes](https://hub.docker.com/_/postgres)

### Ejecutar imagen

```powershell
# crear carpeta de datos
New-Item -ItemType Directory -Force -Path "$HOME\.demo\postgres-demo-data"
docker volume create "postgres-demo-data" --opt o=bind --opt type=none --opt device="$HOME\.demo\postgres-demo-data"
# ejecutar contenedor
docker run --name "postgres-demo" -p 5432:5432 -e "POSTGRES_USER=postgres" -e "POSTGRES_PASSWORD=DEMO123*" -e "PGDATA=/var/lib/postgresql/data/pgdata" -v "postgres-demo-data:/var/lib/postgresql/data" -d "postgres:16.3"
# monitorear contenedor
docker logs "postgres-demo" --follow
```

### Conectar por herramienta

```txt
Hostname: localhost
Port: 5432
Username: postgres
Password: DEMO123*
```

### Conectar por bash

```powershell
# conectar a bash de contenedor
docker exec -it "postgres-demo" /bin/bash
# conectar con administrador
psql -h localhost -U postgres
```

### Ejecutar script

```powershell
$container='postgres-demo'
$connection_user='postgres'
Get-Content "C:\\...\script.sql" | docker exec -i $container psql -h localhost -U $connection_user
```

### Base de datos Chinook

```powershell
$container='postgres-demo'
$connection_user='postgres'
Get-Content ".\examples\chinook\Chinook_PostgreSql.sql" | docker exec -i $container psql -h localhost -U $connection_user
```

### Base de datos Evently

```powershell
$container='postgres-demo'
$connection_user='postgres'
Get-Content ".\examples\evently\postgres_attendance_schema.sql" | docker exec -i $container psql -h localhost -U $connection_user
Get-Content ".\examples\evently\postgres_events_schema.sql" | docker exec -i $container psql -h localhost -U $connection_user
Get-Content ".\examples\evently\postgres_ticketing_schema.sql" | docker exec -i $container psql -h localhost -U $connection_user
Get-Content ".\examples\evently\postgres_users_schema.sql" | docker exec -i $container psql -h localhost -U $connection_user
```
