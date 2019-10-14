class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Token
  include Mongoid::Attributes::Dynamic


  devise :database_authenticatable, :registerable, :async, 
         :recoverable, :rememberable, :trackable, 
         :timeoutable, :lockable,
         :authentication_keys => [:email]

  ## Database authenticatable
  field :email,              :type => String, :default => "" 
  field :name,               :type => String, :default => ""
  field :contact_number, type: String 
  field :encrypted_password, :type => String, :default => ""
  field :employee_number, :type => String
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time
  ## Rememberable
  field :remember_created_at, :type => Time
  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String
  ## Lockable
  field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  field :locked_at,       :type => Time

  #other fields
  field :country_name,    :type => String
  field :first_name,    :type => String
  field :last_name,    :type => String
  field :reporting_manager, type: String
  field :job_title, type: String
  field :verified_at,    :type => Time
  field :registered_ip_address, :type => String
  field :auth_token,    :type => String

  has_one :profile, :dependent => :destroy
  has_one :bank_account, :dependent => :destroy
  has_one :leave_management, :dependent => :destroy
  
  
end