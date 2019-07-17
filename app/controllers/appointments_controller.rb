class AppointmentsController < ApiController

  def index
    @obj = []
    appointments = Appointment.all
    appointments.each do |appointment|
      @obj.push(get_appointment(appointment))
    end
    render json: {appointments: @obj}
  end

  def create
    begin
      @appointment = Appointment.new(appointment_params)
      ActiveRecord::Base.transaction do
        @appointment.save!
      end
      render status: 200, json: {message: 'Cita creada exitosamente!'}
    rescue
      render status: 200, json: {error: true, messages: @appointment.errors}
    end
  end

  def update
    @appointment = Appointment.find_by_id(params[:id])
    render json: {error: true, message: 'La cita no existe'} if @appointment.nil?
    unless @appointment.nil?
      begin
        ActiveRecord::Base.transaction do
          @appointment.update!(appointment_params)
        end
        render status: 200, json: {message: 'Cita actualizada exitosamente!'}
      rescue
        render status: 200, json: {error: true, messages: @appointment.errors}
      end
    end
  end

  def show
    @appointment = Appointment.find_by_id(params[:id])
    render json: {error: true, message: 'La cita no existe'} if @appointment.nil?
    unless @appointment.nil?
      @obj = get_appointment(@appointment)
      render json: {appointment: @obj}
    end
  end

  def delete
    @appointment = Appointment.find_by_id(params[:id])
    if @appointment.nil?
      render json: {error: "La cita no existe"}
    else
      if @appointment.destroy
        render json: {message: "La cita se ha eliminado exitosamente"}
      else
        render json: {error: true, messages: @appointment.errors}
      end
    end
  end

  def get_today_appointments
    @doctor = User.find_by_id(params[:id])
    if @doctor.nil? or @doctor.role_id != 2
      render status: 200, json: {error: true, message: 'El doctor no existe.'}
    else
      @obj = []
      @appointments = Appointment.where( doctor_id: @doctor.id, appointment_date: Date.current)
      @appointments.each do |appointment|
        @obj.push(get_appointment(appointment))
      end
      render status: 200, json: {appointments: @obj}
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

