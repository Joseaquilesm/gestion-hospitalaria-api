class AppointmentsController < ApiController

  before_action :authorize_request
  before_action :verify_users_appointments

  def index
    @obj = []
    @appointments = Appointment.all
    @appointments.order(created_at: :desc)
    @appointments.each do |appointment|
      @obj.push(get_appointment(appointment))
    end
    render status: 200, json: {appointments: @obj, isTokenValid: is_token_valid?}
  end

  def create
    begin
      @appointment = Appointment.new(appointment_params)
      ActiveRecord::Base.transaction do
        @appointment.save!
      end
      render status: 200, json: {message: 'Cita creada exitosamente!', isTokenValid: is_token_valid?}
    rescue
      render status: 200, json: {error: true, messages: @appointment.errors, isTokenValid: is_token_valid?}
    end
  end

  def update
    @appointment = Appointment.find_by_id(params[:id])
    render json: {error: true, message: 'La cita no existe', isTokenValid: is_token_valid?} if @appointment.nil?
    unless @appointment.nil?
      begin
        ActiveRecord::Base.transaction do
          @appointment.update!(appointment_params)
        end
        render status: 200, json: {message: 'Cita actualizada exitosamente!', isTokenValid: is_token_valid?}
      rescue
        render status: 200, json: {error: true, messages: @appointment.errors, isTokenValid: is_token_valid?}
      end
    end
  end

  def show
    @appointment = Appointment.find_by_id(params[:id])
    render status: 200, json: {error: true, message: 'La cita no existe', isTokenValid: is_token_valid?} if @appointment.nil?
    unless @appointment.nil?
      @obj = get_appointment(@appointment)
      render status: 200, json: {appointment: @obj, isTokenValid: is_token_valid?}
    end
  end

  def get_today_appointments
    @doctor = User.find_by_id(params[:id])
    if @doctor.nil? or @doctor.role_id != 2
      render status: 200, json: {error: true, message: 'El doctor no existe.', isTokenValid: is_token_valid?}
    else
      @obj = []
      @appointments = Appointment.where(doctor_id: @doctor.id, appointment_date: Date.current)
      @appointments.order(created_at: :desc)
      @appointments.each do |appointment|
        @obj.push(get_appointment(appointment))
      end
      render status: 200, json: {appointments: @obj, isTokenValid: is_token_valid?}
    end
  end

  private

  def appointment_params
    params.permit(:appointment_date, :hour_date, :motive, :doctor_id, :secretary_id, :patient_id, :previous_assistance,
                  :accompanied, :consultation_type, :familiar_name, :familiar_relation, :familiar_phone_number, :reference_id)
  end

  def get_appointment(appointment)
    obj = {}
    obj.merge!(appointment.attributes)
    patient = Patient.find_by_id(appointment.patient_id)
    doctor = User.find_by_id(appointment.doctor_id)
    obj.merge!(doctor_identificacion: doctor.person.identification)
    obj.merge!(doctor_name: doctor.person.name)
    obj.merge!(doctor_last_name: doctor.person.last_name)
    obj.merge!(patient_identificacion: patient.person.identification)
    obj.merge!(patient_name: patient.person.name)
    obj.merge!(patient_last_name: patient.person.last_name)
    obj.merge!(patient_birthday: patient.person.birthday)
    obj.merge!(patient_occupation: patient.occupation)
    obj.merge!(patient_civil_status: patient.person.civil_status)
    obj.merge!(patient_phone_number: patient.person.phone_number)
    obj.merge!(patient_address: patient.person.address)
    obj.merge!(patient_email: patient.person.email)
    obj
  end
end

