# notes-sql / postgres

- [Documentación oficial 16](https://www.postgresql.org/docs/16/index.html)

## Bases de Datos de Ejemplo

- [Genérica](https://github.com/lerocha/chinook-database)

## Docker

- [Imágenes](https://hub.docker.com/_/postgres)

### Ejecutar imagen

```powershell
# crear carpeta de datos
New-Item -ItemType Directory -Force -Path "$HOME\.demo\postgres-demo-data"
docker volume create "postgres-demo-data" --opt o=bind --opt type=none --opt device="$HOME\.demo\postgres-demo-data"
# ejecutar contenedor
docker run --name "postgres-demo" -p 5432:5432 -e "POSTGRES_PASSWORD=DEMO123*"-e "PGDATA=/var/lib/postgresql/data/pgdata" -v "postgres-demo-data:/var/lib/postgresql/data" -d "postgres:16.3"
# monitorear contenedor
docker logs "postgres-demo" --follow
```
