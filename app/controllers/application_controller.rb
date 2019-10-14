class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def is_admin
		if current_user.present? && current_user.email.eql?("aathresh@paraginfotech.com")
		  @is_admin = true
		else
		  @is_admin = false
		end
	end
end
