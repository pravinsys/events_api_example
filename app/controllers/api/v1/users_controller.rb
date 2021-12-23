class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate, :only => [:create]

  def index
    @users = User.all
    render json: @users, each_serializer: UserSerializer
  end

  def create
    user = User.new(create_params)

    if user.save
      render json: user, serializer: UserSerializer, status: :created
    else
      render json: error_json(user), status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def error_json(user)
    { errors: user.errors.full_messages }
  end

end
