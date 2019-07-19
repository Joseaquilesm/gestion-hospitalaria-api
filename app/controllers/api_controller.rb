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
    rescue JWT::DecodeError
      render status: 200, json: {errors: {isTokenValid: false}}
    end
  end

  def is_token_valid?
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound
      return false
    rescue JWT::DecodeError
      return false
    end
    return true
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

  # Restrictions
  def verify_admin_users
    if action_name == 'get_doctors' or action_name == 'get_doctor'
      unless @current_user.admin? or @current_user.secretary?
        return render status: 200, json: {error: true, message: 'Debes ser administrador o secretaria para realizar esta función', isTokenValid: is_token_valid?}
      end
    else
      unless @current_user.admin?
        return render status: 200, json: {error: true, message: 'Debes ser administrador para realizar esta función', isTokenValid: is_token_valid?}
      end
    end
  end

  def verify_users_patients
    case action_name
    when 'create'
      if @current_user.doctor?
        return render status: 200, json: {error: true, message: 'Debes ser administrador, secretaria o enfermera para realizar esta función', isTokenValid: is_token_valid?}
      end
    when 'update'
      if @current_user.doctor? or @current_user.nurse?
        return render status: 200, json: {error: true, message: 'Debes ser administrador o secretaria para realizar esta función', isTokenValid: is_token_valid?}
      end
    end
  end

  def verify_users_appointments
    if @current_user.doctor? or @current_user.nurse?
      return render status: 200, json: {error: true, message: 'Debes ser administrador o secretaria para realizar esta función', isTokenValid: is_token_valid?}
    end
  end

  def verify_users_consultations
    unless @current_user.doctor?
      return render status: 200, json: {error: true, message: 'Debes ser doctor para realizar esta función', isTokenValid: is_token_valid?}
    end
  end
end
