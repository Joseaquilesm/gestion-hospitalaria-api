class UsersController < ApiController
  def index
    users_filtered = User.all unless params[:role].present?
    users_filtered = User.where(role: Role.find_by_name(params[:role])) if params[:role].present?
    @obj = []
    users_filtered.each do |user|
      attrs = user.person.attributes
      attrs.merge!(user.attributes.except('person_id', 'specialty_id', 'role_id'))
      attrs.merge!(role: user.role.name)
      attrs.merge!(specialty: user.specialty.name) unless user.specialty.nil?
      attrs.merge!(user.work_day.attributes) unless user.work_day.nil?
      @obj.push(attrs)
    end
    render json: {admins: @obj} if params[:role] == 'admin'
    render json: {doctors: @obj} if params[:role] == 'doctor'
    render json: {nurses: @obj} if params[:role] == 'enfermera'
    render json: {secretaries: @obj} if params[:role] == 'secretaria'
    render json: {employees: @obj} unless params[:role].present?
  end

  def create
    @person = Person.new(person_params)
    @user = User.new(user_params.except(:role, :specialty))
    @user.role = Role.find_by_name(params[:role])
    @user.specialty = Specialty.find_by_name(params[:specialty]) if @user.role.name == 'doctor'
    @person.save if @person.valid? && @user.valid?
    @user.person = @person if @person.id?
    @user.save if @user.valid? && @person.id?
    if @user.id?
      @user.update(work_day: WorkDay.create(work_day_params))
      render status: 200, json: {
          message: "El usuario se ha creado exitosamente!"
      }
    else
      @messages = {}
      fill_errors(@person.errors, @messages)
      fill_errors(@user.errors, @messages)
      render status: 200, json: {
          error: true, messages: @messages
      }
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    render status: 200, json: {error: true, message: 'El usuario no existe'} if @user.nil?
    unless @user.nil?
      @obj = @user.person.attributes.merge(@user.attributes.except('person_id'))
      @obj.merge!(@user.work_day.attributes) unless @user.work_day.nil?
      render status: 200, json: {
          user: @obj
      }
    end
  end

  def update
    @user = User.find_by_id(params[:id])
    render json: {error: true, message: 'El usuario no existe'} if @user.nil?
    unless @user.nil?
      render json: {message: 'Se han actualizado los datos del usuario exitosamente!'} if @user.person.update(person_params) &&
          @user.update(patient_params) && @user.work_day.update(work_day_params)
      unless @user.person.errors.empty? && @user.errors.empty? && @user.work_day.errors.empty?
        @messages = {}
        fill_errors(@user.person.errors, @messages)
        fill_errors(@user.errors, @messages)
        fill_errors(@user.work_day.errors, @messages)
        render status: 200, json: {
            error: true, messages: @messages
        }
      end
    end
  end

  private

  def user_params
    params.permit(:role, :specialty, :entry_time, :departure_time)
  end

  def work_day_params
    params.permit(:monday, :tuesday, :wednesday, :thursday, :friday,
                  :saturday, :sunday)
  end
end
