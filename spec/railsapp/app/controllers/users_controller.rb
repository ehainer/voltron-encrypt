class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to edit_user_path(@user), notice: "User created successfully."
    else
      redirect_to edit_user_path(@user), alert: @user.errors.full_messages
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to edit_user_path(@user), notice: "User updated successfully."
    else
      redirect_to edit_user_path(@user), alert: @user.errors.full_messages
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :phone, :car_id, car_ids: [])
    end

end
