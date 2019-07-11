class AuthenticationController < ApiController
  before_action :authorize_request, except: :login

  def login
    @user = User.joins(:person).where(people: {email: params[:email]}).first
    if @user.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
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
