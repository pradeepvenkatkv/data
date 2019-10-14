class AdministrationController < ApplicationController
	before_filter :authenticate_user!


  def new
  	@stationary = Administration.new
  end

  def create
  	@stationary_details = Administration.new(stationary_params)
    @stationary_details.profile_id = current_user.profile.id
    @stationary_details.save
    redirect_to administration_index_path, notice: 'Request sent successfully '
  end




  private

    def stationary_params
      params.require(:administration).permit(:stationary_type, :category,:product,:quantity)	
    end  

end


