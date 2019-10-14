class NotificationWorker
	include Sidekiq::Worker
	sidekiq_options :queue => :mailer


  def perform(mailer, input_data)
    puts "NotificationWorker coming"
    puts mailer.inspect
  	if mailer.eql?("welcome_email")
  		puts input_data.inspect
      @user_id = User.find(input_data["$oid"])
      puts "NotificationWorker coming with user id"
      UserMailer.welcome_email(@user_id).deliver
    elsif mailer.eql?("leave_approval_email")
      @mail_details = input_data
      puts "coming to mail details"
      puts @mail_details.inspect
      puts "coming to mail details"
      UserMailer.leave_approval_email(@mail_details).deliver
    elsif mailer.eql?("leave_reject_email")
      @mail_details = input_data
      puts "coming to mail details"
      puts @mail_details.inspect
      puts "coming to mail details"
      UserMailer.leave_reject_email(@mail_details).deliver  

    end  
  end

  # def perform(mailer, input_data)
  #   puts "NotificationWorker coming"
  #   puts mailer.inspect
  #   if mailer.eql?("leave_approval_email")
  #     puts input_data.inspect
  #     @user_id = User.find(input_data["$oid"])
  #     puts "NotificationWorker coming with user id"
  #     UserMailer.leave_approval_email(@user_id).deliver
  #   end

  # end


  
end