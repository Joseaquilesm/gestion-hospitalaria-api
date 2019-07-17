class AuthenticationController < ApiController
  before_action :authorize_request, except: :login

  def login
    unless params[:email].present? and params[:password].present?
      render status: 200, json: {error: true, message: 'Datos incorrectos'}
    end

    @user = User.joins(:person).where(people: {email: params[:email]}).first
    if @user.authenticate(params[:password])
      token = JsonWebToken.encode({user_id: @user.id, name: @user.person.name, last_name: @user.person.last_name,
                                   email: @user.person.email, role: @user.role.name, specialty: (@user.specialty.name unless @user.specialty.nil?)})
      time = Time.now + 14.hours.to_i
      render status: 200, json: {token: token, exp: time.strftime("%m-%d-%Y %H:%M"), email: @user.person.email}
    else
      render status: 200, json: {error: true, message: 'Datos incorrectos'}
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
