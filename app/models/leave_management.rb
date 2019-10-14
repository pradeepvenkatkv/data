class LeaveManagement
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::Validations

  field :profile_id, type: String
  field :user_id, type: String
  field :leave_type, type: String
  field :start_date, type: String 
  field :end_date, type: String
  field :reason, type: String
  field :reporting_manager, type: String
  field :status, type: String ,:default => "pending"
  field :employee_number, type: String
  
  belongs_to :profile
end
