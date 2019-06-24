class AppointmentsController < ApiController

  def index
    @appointments = Appointment.all
    render json: {appointments: @appointments}
  end


  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      render json: {message: "La cita ha sido creada"}, status: :ok
    else
      render json: {errors: @appointment.errors.full_messages}
    end
  end

  def update
    @appointment = Appointment.find_by_id(params[:id])
    if @appointment.nil?
      render json: {errors: "La cita no existe"}
    else
      if @appointment.update_attributes(appointment_params)
        render json: {message: "Se han actualizado los datos de la cita exitosamente!"}
      else
        render json: {error: true, messages: @appointment.errors}
      end
    end
  end

  def delete
    @appointment = Appointment.find_by_id(params[:id])
    if @appointment.nil?
      render json: {errors: "La cita no existe"}
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
    params.permit(:appointment_date, hour_date, :motive, doctor_id, secretary_id, patient_id)
  end
end
