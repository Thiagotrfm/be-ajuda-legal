class ApplicationController < ActionController::API
    SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
    before_action :authorized

    def encode_token(payload)
        JWT.encode(payload, SECRET_KEY)
    end

    def auth_header
        request.headers['Authorization']
    end

    def decoded_token
        if auth_header
            token = auth_header.split(' ')[1]
            begin
                JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')
            rescue JWT::DecodeError
                nil
            end
        end
    end

    def logged_in_user
        if decoded_token
            now = Time.now
            user_id = decoded_token[0]['user_id']
            expiration_time = decoded_token[0]['expiration_time'].to_time
            if expiration_time.after? now
                @user = User.find_by(id: user_id)
            end
        end
    end

    def logged_in?
        !!logged_in_user
    end

    def authorized
        render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
    end
end
