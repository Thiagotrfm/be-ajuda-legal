class AuthController < ApplicationController
    before_action :authorized, except: [:login]

    def login
        user = User.find_by(email: params[:email])

        if user && user.authenticate(params[:password])
            token = encode_token({user_id: user.id, expiration_time: Time.now + 2*60*60})
            render json: {user: user.as_json(only: [:id, :name, :last_name, :email]), token: token}
        else
            render json: {error: "Invalid email or password"}
        end
    end
end