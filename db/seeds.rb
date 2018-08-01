# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Role.create(rol_name: 'administrador')
Role.create(rol_name: 'usuario')
Role.create(rol_name: 'veterinario')
user = User.new(
  email: 'admin@correo.com', 
   name: 'admin',
  lastname: 'admin', 
  password: '12345678', 
  password_confirmation: '12345678',
  role_id: '1' 
) 
user.save!
user = User.new(
  email: 'colaborador@correo.com', 
  name: 'colaborador',
  lastname: 'colaborador',
  password: '12345678', 
  password_confirmation: '12345678',
  role_id: '2' 
) 
user.save!
user = User.new(
  email: 'lectura@correo.com', 
  name: 'lectura',
  lastname: 'lectura',
  password: '12345678', 
  password_confirmation: '12345678',
  role_id: '3' 
) 
user.save!