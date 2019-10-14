class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_admin

  protect_from_forgery

################################### PROFILE MODULE ##########
  def index
    if !@is_admin
      flash[:alert] = "Not authorized to access this page"
      redirect_to root_url
    else
      if params[:id].present?
        @profile = Profile.where(id: params[:id]).last
      else
        @profile = Profile.all.desc(:created_at)
        @profile_count = Profile.count
        @all_users =  Kaminari.paginate_array(@profile).page(params[:page]).per(10)
      end
    end
  end

  def profile_delete
    if !@is_admin
      flash[:alert] = "Not authorized to access this page"
      redirect_to root_url
    else
      @profile = Profile.where(id: params[:id]).last
      @profile.user.destroy
      if @profile.destroy
        flash[:notice] = "Employee Deleted Successfully"
        redirect_to admin_index_path    
      else
        redirect_to admin_index_path 
      end
    end    
  end

  

  def profile_edit
    if !@is_admin
      flash[:alert] = "Not authorized to access this page"
      redirect_to root_url
    else  
      @profile = Profile.where(:id=>params[:id]).last
      puts @profile.inspect
      puts "coming to update_profile"
    end    
  end

  def update_profile
    puts @profile.inspect
    if(@profile = Profile.where(:id=>params["profile"][:profile_id]).last.present?)
      puts params
      @profile = Profile.where(:id=>params["profile"][:profile_id]).last.update(profile_params)
      flash[:notice] = "Employee Details Updated Successfully"
      redirect_to admin_index_path
    else
      flash[:notice] = "Employee which you are trying to update is not availabel"
      redirect_to admin_index_path
    end
    
  end

  def download_employees
    @all_users = Profile.all.desc(:created_at)
    csv_string = CSV.generate do |csv|
      csv << ["EMPLOYEE NUMBER","DATE OF JOINING","NAME","GENDER","EMAIL","MOBILE NUMBER","ALTERNATE MOBILE NUMBER","DATE OF BIRTH", "ADDRESS", "JOB TITTLE", "REPORTING MANAGER", "STATUS","CREATED AT",]
      @all_users.each do |user|
        csv << [user.employee_number.present? ? user.employee_number : '',user.date_of_joining.present? ? user.date_of_joining : '', 
               user.name.present? ? user.name : '', user.gender.present? ? user.gender : '',user.email.present? ? user.email : '', user.contact_number.present? ? user.contact_number : '',
               user.emergency_contact.present? ? user.emergency_contact : '',user.date_of_birth.present? ? user.date_of_birth : '', user.address.present? ? user.address : '',
           user.job_title.present? ? user.job_title : '', user.reporting_manager.present? ? user.reporting_manager : '', user.status.present? ? user.status : '',user.created_at.present? ? user.created_at.strftime('%d-%m-%Y %H:%M:%S') : '']
      end
    end
      send_data csv_string,
    :type => 'text/csv; charset=iso-8859-1; header=present',
    :disposition => "attachment; filename=Employees.csv"
  end

  ########################### BANK MODULE ################################

  def employee_bank_details
    if !@is_admin
      flash[:alert] = "Not authorized to access this page"
      redirect_to root_url
    else
      @employee_bank_details = BankAccount.all.desc(:created_at)
      @bank_details_count = BankAccount.count
      @bank_details =  Kaminari.paginate_array(@employee_bank_details).page(params[:page]).per(10)
      puts  @bank_details.inspect
      puts "coming to  @bank_details"
    end
  end 

  def download_bank_accounts
    @bank_account_users = BankAccount.all.desc(:created_at)
    csv_string = CSV.generate do |csv|
      csv << ["EMPLOYEE ID","FULL NAME","ACCOUNT NUMBER ","BANK NAME","IFSC CODE","BRANCH NAME","CREATED AT"]
      @bank_account_users.each do |bank|
        csv << ['',bank.full_name.present? ? bank.full_name : '',bank.account_number.present? ? bank.account_number : '',bank.bank_name.present? ? bank.bank_name : '',bank.ifsc.present? ? bank.ifsc : '',bank.branch_name.present? ? bank.branch_name : '',
          bank.created_at.present? ? bank.created_at.strftime('%d-%m-%Y %H:%M:%S') : '']
      end
    end
      send_data csv_string,
    :type => 'text/csv; charset=iso-8859-1; header=present',
    :disposition => "attachment; filename=Bank_account_Employees.csv"
  end

  ########################### LEAVE MANAGEMENT MODULE ################################


  def leave_application
    if !@is_admin
      flash[:alert] = "Not authorized to access this page"
      redirect_to root_url
    else
      @leave_applications = LeaveManagement.all.desc(:created_at)
      @leave_details =  Kaminari.paginate_array(@leave_applications).page(params[:page]).per(10)
    end
  end 

  def approve_leave
    if !@is_admin
      flash[:alert] = "Not authorized to access this page"
      redirect_to root_url
    else
      @leave_applications = LeaveManagement.where(:id=>params[:id]).last
      @leave_details = @leave_applications.status.eql?("pending")
      puts "comint to profile"
      puts @leave_applications.profile.inspect
      puts "comint to profile"
      @mail_details = {"user_name" => @leave_applications.profile.name, "user_email" => @leave_applications.profile.email, 
                       "start_date"  => @leave_applications.start_date , "end_date"  => @leave_applications.end_date}
      puts "in controller mailer"
      puts @mail_details.inspect
      puts "in controller mailer"
      NotificationWorker.perform_async("leave_approval_email", @mail_details)
      flash[:notice] = "Leave Application Approved Successfully"
      redirect_to leave_application_admin_index_path
    end
  end

  def reject_leave
    if !@is_admin
      flash[:alert] = "Not authorized to access this page"
      redirect_to root_url
    else
      @leave_applications = LeaveManagement.where(:id=>params[:id]).last
      @leave_details = @leave_applications.status.eql?("pending")
      puts "comint to profile"
      puts @leave_applications.profile.inspect
      @mail_details = {"user_name" => @leave_applications.profile.name, "user_email" => @leave_applications.profile.email, 
                       "start_date"  => @leave_applications.start_date , "end_date"  => @leave_applications.end_date}
      puts "in controller mailer"
      puts @mail_details.inspect
      puts "in controller mailer"
      NotificationWorker.perform_async("leave_reject_email", @mail_details)
      flash[:notice] = "Leave Application Rejected"
      redirect_to leave_application_admin_index_path
    end

  end  

  

  private

    def profile_params
      params.require(:profile).permit(:name, :employee_number,:email,:contact_number,:emergency_contact,:address,:date_of_joining,:date_of_birth,:gender,:reporting_manager,:job_title,:status)
    end

    


end