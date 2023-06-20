class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  # POST /auth/login
  def login
    @tutor = Tutor.find_by_email(params[:email])
    unless @tutor&.authenticate(params[:password])
      return render json: { error: 'unauthorized' }, status: :unauthorized
    end

    token = JsonWebToken.encode(tutor_id: @tutor.id)
    time = 24.hours.from_now
    render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                    username: @tutor.username }, status: :ok
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
