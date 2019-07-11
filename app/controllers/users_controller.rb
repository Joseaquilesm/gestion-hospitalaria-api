class UsersController < ApiController
  # before_action :authorize_request, except: [:index, :create]

  def index
    users_filtered = User.all unless params[:role].present?
    users_filtered = User.where(role: Role.find_by_name(params[:role])) if params[:role].present?
    @obj = []
    users_filtered.each do |user|
      @attrs = get_info(user)
      @obj.push(@attrs)
    end
    render json: {admins: @obj} if params[:role] == 'admin'
    render json: {doctors: @obj} if params[:role] == 'doctor'
    render json: {nurses: @obj} if params[:role] == 'enfermera'
    render json: {secretaries: @obj} if params[:role] == 'secretaria'
    render json: {employees: @obj} unless params[:role].present?
  end

  def get_admins
    @admins = User.where(role: Role.find_by_name('admin'))
    @obj = get_all_info(@admins)
    render status: 200, json: {admins: @obj}
  end

  def get_doctors
    @doctors = User.where(role: Role.find_by_name('doctor'))
    @obj = get_all_info(@doctors)
    render status: 200, json: {doctors: @obj}
  end

  def get_doctor
    @doctor = User.find_by_id(params[:id])
    render status: 200, json: {doctor: @doctor}
  end

  def get_nurses
    @nurses = User.where(role: Role.find_by_name('enfermera'))
    @obj = get_all_info(@nurses)
    render status: 200, json: {nurses: @obj}
  end

  def get_secretaries
    @secretaries = User.where(role: Role.find_by_name('secretaria'))
    @obj = get_all_info(@secretaries)
    render status: 200, json: {secretaries: @obj}
  end

  def create
    @person = Person.new(person_params)
    @user = User.new(user_params.except(:role, :specialty))
    @work_day = WorkDay.new(work_day_params)
    @user.role = Role.find_by_name(params[:role])
    @user.specialty = Specialty.find_by_name(params[:specialty])
    begin
      ActiveRecord::Base.transaction do
        @person.save!
        @work_day.save!
        @user.person = @person
        @user.work_day = @work_day
        @user.save!
      end
      render status: 200, json: {message: 'Usuario creado exitosamente!'}
    rescue StandardError
      @messages = get_errors(@person, @user, @work_day)
      render status: 200, json: {error: true, messages: @messages}
    end
  end

  def show
    user = User.find_by_id(params[:id])
    render status: 200, json: {error: true, message: 'El usuario no existe'} if user.nil?
    unless user.nil?
      @obj = get_info(user)
      render status: 200, json: {user: @obj}
    end
  end

  def update
    @user = User.find_by_id(params[:id])
    render json: {error: true, message: 'El usuario no existe'} if @user.nil?
    unless @user.nil?
      @person = @user.person
      @work_day = @user.work_day unless @user.work_day.nil?
      begin
        ActiveRecord::Base.transaction do
          @person.update!(person_params)
          @user.update!(user_params)
          @work_day.update!(work_day_params)
        end
        render status: 200, json: {message: 'Usuario actualizado exitosamente!'}
      rescue StandardError
        @messages = get_errors(@person, @user, @work_day)
        render status: 200, json: {error: true, messages: @messages}
      end
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

  def get_errors(person, user, work_day)
    messages = {}
    fill_errors(person.errors, messages)
    fill_errors(user.errors, messages)
    fill_errors(work_day.errors, messages)
    messages
  end

  def get_all_info(users)
    obj = []
    users.each do |user|
      obj.push(get_info(user))
    end
    obj
  end

  def get_info(user)
    obj = {}
    obj.merge!(id: user.id)
    obj.merge!(user.person.attributes.except('id'))
    obj.merge!(user.attributes.except('id', 'person_id', 'specialty_id', 'role_id'))
    obj.merge!(role: user.role.name)
    obj.merge!(specialty: user.specialty.name) if user.role.name == 'doctor'
    obj.merge!(user.work_day.attributes.except('id')) unless user.work_day.nil?
    obj
  end
end
