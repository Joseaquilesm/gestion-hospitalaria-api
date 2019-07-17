Specialty.create(name: 'Cardiología') unless Specialty.find_by_name('Cardiología')
Specialty.create(name: 'Psiquiatría') unless Specialty.find_by_name('Psiquiatría')
Specialty.create(name: 'Psicología') unless Specialty.find_by_name('Psicología')
Role.create(name: 'Administrador') unless Role.find_by_name('Administrador')
Role.create(name: 'Doctor') unless Role.find_by_name('Doctor')
Role.create(name: 'Enfermera') unless Role.find_by_name('Enfermera')
Role.create(name: 'Secretaria') unless Role.find_by_name('Secretaria')
AdminUser.create!(email: 'admin@gmail.com', password: 'password', password_confirmation:
    'password') unless AdminUser.find_by_email('admin@gmail.com')