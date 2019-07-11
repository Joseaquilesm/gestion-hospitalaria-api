class ApiController < ActionController::API
  protected

  def not_found
    render status: 200, json: {error: true, message: 'No existe.'}
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render status: 200, json: {errors: true, message: e.message}
    rescue JWT::DecodeError => e
      render status: 200, json: {errors: e.message}
    end
  end

  def fill_errors(obj, hash)
    obj.each do |attr, msg|
      hash[attr] = msg
    end
  end

  def person_params
    params.permit(:identification, :name, :last_name, :address, :phone_number, :genre, :birthday,
                  :birth_place, :nationality, :email, :civil_status)
  end
end
