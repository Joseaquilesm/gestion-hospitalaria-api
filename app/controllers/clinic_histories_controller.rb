class ClinicHistoriesController < ApiController
  def show
    @clinic_history = ClinicHistory.find(params[:id])
    if @clinic_history.nil?
      render json: {errors: "Clinic History non existent"}
    else
      render json: {clinic_history: @clinic_history}, status: :ok
    end
  end

  def update

  end
end
