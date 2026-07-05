#!/bin/bash
# Se ejecuta automáticamente la PRIMERA VEZ que se crea el volumen de MySQL.
# No creamos las bases despacho_db/ventas_db aquí: tus apps Spring Boot ya lo
# hacen solas gracias a "createDatabaseIfNotExist=true" en la URL de conexión.
# Aquí solo le damos permiso al usuario de la app para poder crearlas.
# Si necesitas que esto se vuelva a ejecutar (tras cambiar este archivo),
# borra el volumen con: docker compose down -v

set -e

mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<-EOSQL
    GRANT ALL PRIVILEGES ON despacho_db.* TO '${DB_USERNAME}'@'%';
    GRANT ALL PRIVILEGES ON ventas_db.* TO '${DB_USERNAME}'@'%';
    FLUSH PRIVILEGES;
EOSQL

echo "Permisos otorgados sobre despacho_db y ventas_db."
