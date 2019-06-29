rai# README

Instrucciones para utilizar el API.

## Para iniciar el servidor de Rails:

#### Puerto 3000 (por defecto):

rails s

#### Cualquier otro puerto:

rails s -p 3001

## Para reiniciar la base de datos:

rails db:reset

## Para ejecutar las migraciones:

rails db:migrate

## Para hacer requests:

#### Pacientes:

- Obtener todos los pacientes (GET): /api/patients
- Crear (POST): /api/patients
- Obtener un paciente (GET): /api/patients/id
- Actualizar un paciente (PUT): /api/patients/id

#### Usuarios:

**NOTA:** Para obtener y crear los usuarios se necesita un parámetro **role**, que puede ser **doctor**, **enfermera** o **secretaria**

- Obtener todos los usuarios (GET): /api/users
- Crear (POST): /api/users
- Obtener un usuario (GET): /api/users/id
- Actualizar un usuario (PUT): /api/users/id
