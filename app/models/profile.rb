class Profile
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::Validations
  include Mongoid::Token
  include Mongoid::Attributes::Dynamic

  # token :field_name => :profile_id, :length => 12, :retry_count => 0, :pattern => "SN%d4"
  field :user_id, type: String
  field :name, type: String
  field :contact_number, type: String 
  field :emergency_contact, type: String
  field :date_of_joining, type: String
  field :date_of_birth, type: String
  field :reporting_manager, type: String
  field :job_title, type: String
  field :status, type: String ,:default => "Active"
  field :address, type: String
  field :employee_number, type: String
  field :email, type: String
  field :gender, type: String
  
    
  belongs_to :user

  has_one :bank_account, :dependent => :destroy
  has_many :leave_management, :dependent => :destroy
  

  def full_name
    if first_name.present? && last_name.present?
      "#{first_name.split(" ")[0].humanize} #{last_name.humanize}"
    end
  end

end
