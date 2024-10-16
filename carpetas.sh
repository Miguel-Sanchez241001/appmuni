#!/bin/bash

echo "Creando estructura de carpetas para el proyecto Flutter..."

mkdir -p lib/core/errors \
lib/core/usecases \
lib/core/utils \
lib/features/usuarios/data/models \
lib/features/usuarios/data/repositories \
lib/features/usuarios/domain/entities \
lib/features/usuarios/domain/repositories \
lib/features/usuarios/domain/usecases \
lib/features/usuarios/presentation/viewmodels \
lib/features/usuarios/presentation/pages \
lib/features/usuarios/presentation/widgets \
lib/features/equipos/data/models \
lib/features/equipos/data/repositories \
lib/features/equipos/domain/entities \
lib/features/equipos/domain/repositories \
lib/features/equipos/domain/usecases \
lib/features/equipos/presentation/viewmodels \
lib/features/equipos/presentation/pages \
lib/features/equipos/presentation/widgets \
lib/features/mantenimientos/data/models \
lib/features/mantenimientos/data/repositories \
lib/features/mantenimientos/domain/entities \
lib/features/mantenimientos/domain/repositories \
lib/features/mantenimientos/domain/usecases \
lib/features/mantenimientos/presentation/viewmodels \
lib/features/mantenimientos/presentation/pages \
lib/features/mantenimientos/presentation/widgets \
lib/injection_container

echo "Estructura de carpetas creada con éxito."

