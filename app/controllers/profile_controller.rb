class ProfileController < ApplicationController
  before_filter :authenticate_user!


	def index
    @user = User.where(:id=>current_user.id).last
    @profile = @user.profile

    puts @profile.inspect
    puts 'coming to @profile'
  end

  def new
  	@profile = Profile.new
  end	

  def create  
    puts params.inspect
    puts "coming"
    if Profile.where(name: params[:profile]["name"]).last.present?
      flash[:alert] = "User Name with the Name '#{params[:profile]["name"]}' already exists."
      redirect_to new_user_path
    else
      @profile_count = Profile.count
      puts "@profile_count"
      puts @profile_count.inspect
      puts "@profile_count"
      @userprofile= {'name'=>params[:profile]['name'],
                        'email'=>params[:profile]['email'],
                        'employee_number' => "1600" +(@profile_count + 1).to_s,
                        'password'=>'12345678',
                        'password_confirmation'=>'12345678',
                    }

      @userprofile.inspect
      puts "coming to @userprofile"
      @user = User.new(@userprofile)
      @user.save
      @profile = Profile.new(user_params)
      @profile.employee_number = "1600" +(@profile_count + 1).to_s
      @profile.user_id=@user.id
      puts "coming to user"
      @user.inspect
      puts "coming to user"
      if @profile.save
        NotificationWorker.perform_async("welcome_email", @user.id)
        flash[:notice] = "New Employee Created Successfully"
        redirect_to admin_index_path
      else
        render 'new'
      end  
    end
  end

  def edit
    @profile = Profile.where(:id=>params[:id]).last
    puts @profile.inspect
    puts "coming to update_profile"
  end

  def update
    @profile = current_user.profile.update(user_params)
    flash[:notice] = "Employee Details Updated Successfully"
    redirect_to profile_index_path
  end


  private

  def user_params
    params.require(:profile).permit(:name, :employee_number,:email,:contact_number,:emergency_contact,:address,:date_of_joining,:date_of_birth,:gender,:status,:user_id)
  end

  
end
 