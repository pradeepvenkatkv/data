class ParagInfotechDevDeviseMailer < Devise::Mailer

  #default from: "#{ENV['EMAIL_NOTIFICATION']}"
  default from: "\"ParagInfotech\" <noreply@identityverification.com>"
  #  def confirmation_instructions(record, token, opts={})
  #   super

  #   headers = {
  #       :subject => "Dear #{resource.first_name.camelize} #{resource.last_name.camelize}, confirm your email."
  #   }
  # end

  def reset_password_instructions(record, token, opts={})
    super
    headers = {
        :subject => "Dear #{resource.first_name.camelize} #{resource.last_name}, reset your password"
    }
  end

  def unlock_instructions(record, token, opts={})
    super
    headers = {
        :subject => "Dear #{resource.first_name.camelize} #{resource.last_name.camelize}, unlock your account"
    }
  end

  private

   def headers_for(action, opts)
    if action == :confirmation_instructions
      headers = {
        :subject => "Dear #{resource.first_name.camelize} #{resource.last_name}, please confirm your ParagInfotech email address.",
        :to => resource.email,
        :from => mailer_sender(devise_mapping),
        :reply_to => mailer_reply_to(devise_mapping),
        :template_path => template_paths,
        :template_name => action

    }.merge(opts)
    elsif action == :reset_password_instructions
      headers = {
        :subject => "Dear #{resource.first_name.camelize} #{resource.last_name}, reset your ParagInfotech account password",
        :to => resource.email,
        :from => mailer_sender(devise_mapping),
        :reply_to => mailer_reply_to(devise_mapping),
        :template_path => template_paths,
        :template_name => action
    }.merge(opts)
    else
      headers = {
        :subject => "Dear #{resource.first_name.camelize} #{resource.last_name.camelize}, unlock your ParagInfotech account",
        :to => resource.email,
        :from => mailer_sender(devise_mapping),
        :reply_to => mailer_reply_to(devise_mapping),
        :template_path => template_paths,
        :template_name => action
    }.merge(opts)
    end
   end

end