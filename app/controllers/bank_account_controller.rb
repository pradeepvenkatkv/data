class BankAccountController < ApplicationController
  before_filter :authenticate_user!


  def new
  	@bank_details = BankAccount.new
  end

  def create  
    @bank_details = BankAccount.new(bank_params)
    @bank_details.profile_id = current_user.profile.id
    @bank_details.save
    redirect_to bank_account_index_path, notice: 'Bank Details added successfully '
  end

  def index
    @profile = current_user.profile
    puts @profile.inspect
    @bank_details = @profile.bank_account
  end
  
  
  private

  def bank_params
    params.require(:bank_account).permit(:full_name, :bank_name,:account_number,:ifsc,:branch_name,:profile_id)
  end

end


