# README

Instrucciones para utilizar el API.

## Para iniciar el servidor de Rails:

_Puerto 3000 (por defecto):_

rails s

_Cualquier otro puerto:_

rails s -p 3001

## Para reiniciar la base de datos:

rails db:reset

## Para hacer requests:

_Pacientes:_

- Obtener (GET): /api/patients
- Crear (POST): /api/patients/create
