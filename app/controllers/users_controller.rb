# frozen_string_literal: true

class UsersController < ApiController
  def index
    users_filtered = User.all unless params[:role].present?
    users_filtered = User.where(role: Role.find_by_name(params[:role])) if params[:role].present?
    @data = get_all_data(users_filtered)
    render json: { admins: @obj } if params[:role] == 'admin'
    render json: { doctors: @obj } if params[:role] == 'doctor'
    render json: { nurses: @obj } if params[:role] == 'enfermera'
    render json: { secretaries: @obj } if params[:role] == 'secretaria'
    render json: { employees: @obj } unless params[:role].present?
  end

  def create
    @person = Person.new(person_params)
    @user = User.new(user_params.except(:role, :specialty))
    @work_day = WorkDay.new(work_day_params)
    @user.role = Role.find_by_name(params[:role])
    if @user.role.name.equal?('doctor')
      @user.specialty = Specialty.find_by_name(params[:specialty])
    end
    begin
      ActiveRecord::Base.transaction do
        @person.save!
        @work_day.save!
        @user.person = @person
        @user.work_day = @work_day
        @user.save!
      end
      render status: 200, json: { message: 'Usuario creado exitosamente!' }
    rescue StandardError
      @messages = get_errors(@person, @user, @work_day)
      render status: 200, json: { error: true, messages: @messages }
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    render status: 200, json: { error: true, message: 'El usuario no existe' } if @user.nil?
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
    render json: { error: true, message: 'El usuario no existe' } if @user.nil?
    unless @user.nil?
      @person = @user.person
      @work_day = @user.work_day unless @user.work_day.nil?
      begin
        ActiveRecord::Base.transaction do
          @person.update!(person_params)
          @user.update!(user_params)
          @work_day.update!(work_day_params)
        end
        render status: 200, json: { message: 'Usuario actualizado exitosamente!' }
      rescue StandardError
        @messages = get_errors(@person, @user, @work_day)
        render status: 200, json: { error: true, messages: @messages }
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

  def get_all_data(users)
    @obj = []
    users.each do |user|
      attrs = user.person.attributes
      attrs.merge!(user.attributes.except('person_id', 'specialty_id', 'role_id'))
      attrs.merge!(role: user.role.name)
      attrs.merge!(specialty: user.specialty.name) unless user.specialty.nil?
      attrs.merge!(user.work_day.attributes) unless user.work_day.nil?
      @obj.push(attrs)
    end
  end

  def get_errors(person, user, work_day)
    messages = {}
    fill_errors(person.errors, messages)
    fill_errors(user.errors, messages)
    fill_errors(work_day.errors, messages)
    messages
  end
end
