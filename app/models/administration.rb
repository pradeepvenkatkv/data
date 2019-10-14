class Administration
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::Validations

  field :full_name, type: String
  field :bank_name, type: String 
  field :account_number, type: String
  field :ifsc, type: String
  field :branch_name, type: String
  field :status, type: String ,:default => "Active"
  field :employee_number, type: String
  
end
