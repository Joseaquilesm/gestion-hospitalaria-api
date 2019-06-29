class ClinicHistoriesController < ApiController
  def show
    @clinic_history = ClinicHistory.find(params[:id])
    if @clinic_history.nil?
      render json: {errors: 'No existe este Historial Clínico'}
    else
      render json: {clinic_history: @clinic_history}, status: :ok
    end
  end

  def update

  end
end
