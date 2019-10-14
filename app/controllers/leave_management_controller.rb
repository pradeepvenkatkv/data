class LeaveManagementController < ApplicationController
  before_filter :authenticate_user!

  def new
  	@leave_details = LeaveManagement.new
  end

  def create  
    @leave_details = LeaveManagement.new(leave_params)
    @leave_details.profile_id = current_user.profile.id
    @leave_details.save
    redirect_to leave_management_index_path, notice: 'Leave Application Sent successfully '
  end

  def index
    @profile = current_user.profile
    puts @profile.inspect
    @leave_profile = @profile.leave_management
    @leave_details = Kaminari.paginate_array(@leave_profile).page(params[:page]).per(10)
    puts 'coming to leave_details'
  end

  def approve_leave
    
  end  
  
  
  private

  def leave_params
    params.require(:leave_management).permit(:leave_type, :start_date,:end_date, :reason,:profile_id)
  end
end
