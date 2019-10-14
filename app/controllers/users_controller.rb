class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @user = User.new
  end


  def create  
    puts params.inspect
    puts "coming"
    puts params[:user]["name"]
    if User.where(name: params[:user]["name"]).last.present?
      flash[:alert] = "User Name with the Name '#{params[:user]["name"]}' already exists."
      redirect_to new_user_path
    else
      @user = User.new(user_params)
      puts "coming to user"
      @user.inspect
      puts "coming to user"
      if @user.save
        redirect_to admin_index_path, notice: 'User was successfully created.'
      else
        render 'new'
      end  
    end
  end


  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorize user
    @user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def user_params
    params.require(:user).permit(:name, :employee_number, :email,:contact_number,:emergency_contact,:address,:date_of_joining,:date_of_birth,:gender,:reporting_manager,:job_title,:status)
  end

end
