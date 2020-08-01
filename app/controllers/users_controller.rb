1
class UsersController < ApplicationController
        
    def index
        articles = User.order('name ASC');
        render json: {status: 'SUCCESS', message:'Lista de voluntários do Ajuda Legal', data:articles}, status: :ok
    end

    def show
        user = User.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded user', data:user},status: :ok
    end

    def create
        user = User.new(user_params)
        if user.save
            render json: {status: 'SUCCESS', message:'Saved user', data:user},status: :ok
        else
            render json: {status: 'ERROR', message:'User not saved', data:user.errors},status: :unprocessable_entity
        end
    end

    def update
        user = User.find(params[:id])
        if user.update_attributes(user_params)
            render json: {status: 'SUCCESS', message:'Updated user', data:user},status: :ok
        else
            render json: {status: 'ERROR', message:'users not update', data:user.erros},status: :unprocessable_entity
        end
    end

    def destroy
        user = User.find(params[:id])
        user.destroy
        render json: {status: 'SUCCESS', message:'Deleted user', data:user},status: :ok
    end

    private
    def user_params
        params.permit(:name, :last_name, :cpf, :email, :password, :password_confirmation)
    end
end