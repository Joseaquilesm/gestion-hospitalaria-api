Specialty.create(name: 'cardiologia') unless Specialty.find_by_name('cardiologia')
Specialty.create(name: 'psiquiatria') unless Specialty.find_by_name('psiquiatria')
Specialty.create(name: 'psicologia') unless Specialty.find_by_name('psicologia')
Role.create(name: 'admin') unless Role.find_by_name('admin')
Role.create(name: 'doctor') unless Role.find_by_name('doctor')
Role.create(name: 'enfermera') unless Role.find_by_name('enfermera')
Role.create(name: 'secretaria') unless Role.find_by_name('secretaria')
AdminUser.create!(email: 'admin@gmail.com', password: 'password', password_confirmation:
    'password') unless AdminUser.find_by_email('admin@gmail.com')