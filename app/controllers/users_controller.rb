class UsersController < ApplicationController
    before_action :authorized, except: [:login, :create]

    def index
        users = User.order('name ASC');
        render json: {status: 'SUCCESS', message:'Lista de voluntários do Ajuda Legal', data:users.as_json(only: [:id, :name, :last_name, :email])}, status: :ok
    end

    def show
        user = User.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded user', data:user.as_json(only: [:id, :name, :last_name, :email])}, status: :ok
    end

    def create
        user = User.new(user_params)
        if user.save
            token = encode_token({user_id: user.id})
            render json: {status: 'SUCCESS', message:'Saved user', data:user.as_json(only: [:id, :name, :last_name, :email]), token: token}, status: :ok
        else
            render json: {status: 'ERROR', message:'User not saved', data:user.errors}, status: :unprocessable_entity
        end
    end

    def update
        user = User.find(params[:id])
        if user.update_attributes(user_params)
            render json: {status: 'SUCCESS', message:'Updated user', data:user.as_json(only: [:id, :name, :last_name, :email])}, status: :ok
        else
            render json: {status: 'ERROR', message:'users not update', data:user.erros}, status: :unprocessable_entity
        end
    end

    def destroy
        user = User.find(params[:id])
        user.destroy
        render json: {status: 'SUCCESS', message:'Deleted user', data:@user.as_json(only: [:id, :name, :last_name, :email])}, status: :ok
    end


    def login
        user = User.find_by(email: params[:email])

        if user && user.authenticate(params[:password])
            token = encode_token({user_id: user.id})
            render json: {user: user.as_json(only: [:id, :name, :last_name, :email]), token: token}
        else
            render json: {error: "Invalid email or password"}
        end
    end

    private
    def user_params
        params.permit(:name, :last_name, :cpf, :email, :password, :password_confirmation)
    end
end