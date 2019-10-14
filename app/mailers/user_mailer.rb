#require 'sidekiq'
class UserMailer < ActionMailer::Base
	default from: "\"ParagInfotech\" <noreply@identityverification.com>"

	def welcome_email(user_id)
		puts "coming to the mailer and user details"
		puts user_id.inspect
		@user = User.where(id: user_id).last
		@email = @user.email
		@first_name = @user.name
		puts @email.inspect
		puts @first_name.inspect
    mail(:to => @email, :subject => "#{@first_name} Welcome to ParagInfotech")
  end

  def leave_reject_email(mail_details)
		puts "coming to the leave_approval_email and user details"
		puts mail_details.inspect
		@mail_details = mail_details
		@email = @mail_details["user_email"]
    puts "GGGGGGGGGGGGGGGGGGGGGGGGgggg"
    puts "coming to @email"
    puts @email.inspect
    puts "coming to @email"
		@first_name = @mail_details["user_name"].titleize
    @start_date = @mail_details["start_date"]
    @end_date = @mail_details["end_date"]
    puts "JJJJJJJJJJJJJJJJJJJJJJJJJJ"
    mail(:to => @email, :subject => "#{@first_name} Leave Application status")
  end


  def leave_approval_email(mail_details)
    puts "coming to the leave_approval_email and user details"
    puts mail_details.inspect
    @mail_details = mail_details
    @email = @mail_details["user_email"]
    puts "GGGGGGGGGGGGGGGGGGGGGGGGgggg"
    puts "coming to @email"
    puts @email.inspect
    puts "coming to @email"
    @first_name = @mail_details["user_name"].titleize
    @start_date = @mail_details["start_date"]
    @end_date = @mail_details["end_date"]
    puts @first_name.inspect
    puts "JJJJJJJJJJJJJJJJJJJJJJJJJJ"
    mail(:to => @email, :subject => "#{@first_name} Leave Application status")
  end

end
