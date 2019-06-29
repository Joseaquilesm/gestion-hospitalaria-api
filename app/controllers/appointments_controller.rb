class AppointmentsController < ApiController

  def index
    @appointments = Appointment.all
    @obj = []
    @appointments.each do |appointment|
      attrs = appointment.attributes
      @patient = Patient.find_by_id(appointment.patient_id)
      @doctor = User.find_by_id(appointment.doctor_id)
      attrs.merge!(doctor_identificacion: @doctor.person.identification)
      attrs.merge!(doctor_name: @doctor.person.name)
      attrs.merge!(doctor_last_name: @doctor.person.last_name)
      attrs.merge!(patient_identificacion: @patient.person.identification)
      attrs.merge!(patient_name: @patient.person.name)
      attrs.merge!(patient_last_name: @patient.person.last_name)
      @obj.push(attrs)
    end
    render json: {appointments: @obj}
  end


  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      render json: {message: "La cita ha sido creada"}, status: :ok
    else
      render json: {error: true, messages:@appointment.errors.full_messages}
    end
  end

  def update
    @appointment = Appointment.find_by_id(params[:id])
    if @appointment.nil?
      render json: {error: true, messages:"La cita no existe"}
    else
      if @appointment.update_attributes(appointment_params)
        render json: {message: "Se han actualizado los datos de la cita exitosamente!"}
      else
        render json: {error: true, messages: @appointment.errors}
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
end
