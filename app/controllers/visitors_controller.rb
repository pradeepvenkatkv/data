class VisitorsController < ApplicationController
  

	def index
    if current_user.present?
      if current_user.email.eql?("aathresh@paraginfotech.com")
        redirect_to admin_index_path
      else
        redirect_to profile_index_path
      end
    end
  end

  def signout
    session.clear
    redirect_to root_path
  end
  
end
