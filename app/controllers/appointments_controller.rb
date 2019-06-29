class AppointmentsController < ApiController

  def index
    appointments = Appointment.all
    @obj = get_appointments(appointments)
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
      render json: {cita: @appointment}
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

  private

  def appointment_params
    params.permit(:appointment_date, :hour_date, :motive, :doctor_id, :secretary_id, :patient_id)
  end

  def get_appointments(appointments)
    obj = []
    appointments.each do |appointment|
      attrs = appointment.attributes
      patient = Patient.find_by_id(appointment.patient_id)
      doctor = User.find_by_id(appointment.doctor_id)
      attrs.merge!(doctor_identificacion: doctor.person.identification)
      attrs.merge!(doctor_name: doctor.person.name)
      attrs.merge!(doctor_last_name: doctor.person.last_name)
      attrs.merge!(patient_identificacion: patient.person.identification)
      attrs.merge!(patient_name: patient.person.name)
      attrs.merge!(patient_last_name: patient.person.last_name)
      obj.push(attrs)
    end
    obj
  end

end
