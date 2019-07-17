class UsersController < ApiController
  before_action :authorize_request
  before_action :verify_admin_users

  def index
    @users = User.all
    @obj = fill_info(@users)
    render status: 200, json: {users: @obj, isTokenValid: is_token_valid?}
  end

  def get_admins
    @admins = User.where(role: Role.find_by_name('Administrador'))
    @obj = fill_info(@admins)
    render status: 200, json: {admins: @obj, isTokenValid: is_token_valid?}
  end

  def get_admin
    @admin = User.find_by_id(params[:id])
    return user_not_found if @admin.nil?
    render status: 200, json: {admin: @admin.get_all_attrs, isTokenValid: is_token_valid?}
  end

  def get_doctors
    @doctors = User.where(role: Role.find_by_name('Doctor'))
    @obj = fill_info(@doctors)
    render status: 200, json: {doctors: @obj, isTokenValid: is_token_valid?}
  end

  def get_doctor
    @doctor = User.find_by_id(params[:id])
    return user_not_found if @doctor.nil?
    render status: 200, json: {doctor: @doctor.get_all_attrs, isTokenValid: is_token_valid?}
  end

  def get_nurses
    @nurses = User.where(role: Role.find_by_name('Enfermera'))
    @obj = fill_info(@nurses)
    render status: 200, json: {nurses: @obj, isTokenValid: is_token_valid?}
  end

  def get_nurse
    @nurse = User.find_by_id(params[:id])
    return user_not_found if @nurse.nil?
    render status: 200, json: {nurse: @nurse.get_all_attrs, isTokenValid: is_token_valid?}
  end

  def get_secretaries
    @secretaries = User.where(role: Role.find_by_name('Secretaria'))
    @obj = fill_info(@secretaries)
    render status: 200, json: {secretaries: @obj, isTokenValid: is_token_valid?}
  end

  def get_secretary
    @secretary = User.find_by_id(params[:id])
    return user_not_found if @secretary.nil?
    render status: 200, json: {secretary: @secretary.get_all_attrs, isTokenValid: is_token_valid?}
  end

  def create
    if params[:password] == params[:password_confirmation]
      @person = Person.new(person_params)
      @user = User.new(user_params.except(:role, :specialty))
      @work_day = WorkDay.new(work_day_params)
      @user.role = Role.find_by_name(params[:role])
      @user.specialty = Specialty.find_by_name(params[:specialty])
      begin
        ActiveRecord::Base.transaction do
          raise ActiveRecord::Rollback if @person.email.blank? || @person.email.nil?
          @person.save!
          @work_day.save!
          @user.person = @person
          @user.work_day = @work_day
          @user.save!
        end
        raise StandardError if @person.email.blank? || @person.email.nil?
        render status: 200, json: {message: 'Usuario creado exitosamente!'}
      rescue StandardError
        @messages = get_errors(@person, @user, @work_day)
        @messages.merge!(email: 'Se necesita un email') if @person.email.blank? || @person.email.nil?
        render status: 200, json: {error: true, messages: @messages}
      end
    else
      render status: 200, json: {error: true, message: 'La contraseña y su confirmación no son iguales.'}
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    return user_not_found if @user.nil?
    render status: 200, json: {user: @user.get_all_attrs, isTokenValid: is_token_valid?}
  end

  def update
    @user = User.find_by_id(params[:id])
    return render status: 200, json: {error: true, message: 'El usuario no existe', isTokenValid: is_token_valid?} if @user.nil?
    begin
      @role = Role.find_by_name(params[:role])
      @specialty = Specialty.find_by_name(params[:specialty])
      ActiveRecord::Base.transaction do
        @user.person.update!(person_params)
        @user.work_day.update!(work_day_params) unless @user.work_day.nil?
        @user.role = @role if params[:role].present?
        @user.specialty = @specialty if params[:specialty].present?
        @user.update!(user_params.except('role', 'specialty'))
      end
      render status: 200, json: {message: 'Usuario actualizado exitosamente!'}
    rescue StandardError
      @messages = get_errors(@user.person, @user, @user.work_day)
      render status: 200, json: {error: true, messages: @messages, isTokenValid: is_token_valid?}
    end
  end

  private

  def user_params
    params.permit(:role, :specialty, :entry_time, :departure_time, :password, :password_confirmation)
  end

  def work_day_params
    params.permit(:monday, :tuesday, :wednesday, :thursday, :friday,
                  :saturday, :sunday)
  end

  def user_not_found
    render status: 200, json: {error: true, message: 'Usuario no encontrado', isTokenValid: is_token_valid?}
  end

  def get_errors(person, user, work_day)
    messages = {}
    fill_errors(person.errors, messages)
    fill_errors(user.errors, messages)
    fill_errors(work_day.errors, messages)
    messages
  end

  def fill_info(users)
    obj = []
    users.each do |user|
      obj.push(user.get_all_attrs)
    end
    obj
  end
end
