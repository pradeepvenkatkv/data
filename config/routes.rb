Rails.application.routes.draw do
  

  root :to => "visitors#index"
  get "signout", to: "visitors#signout"

  resources :products
  devise_for :users
  resources :attendance
  resources :messages
  resources :payslips
  resources :cab_services
  resources :administration

  resources :bank_account do
    collection do
      get 'index'
      post 'create'
      post 'new'
      get 'new'
      get 'account'
      
    end
  end

  resources :leave_management do
    collection do
      get 'index'
      post 'index'
      post 'create'
      post 'new'
      get 'new'
      get 'approve_leave'
      get 'reject_leave'
      
    end
  end

  resources :users do
    collection do
      get 'index'
      post 'create'
      post 'new'
      get 'new'
      
    end
  end

  resources :admin do
    collection do
      get 'index'
      get 'download_employees'
      get 'employee_bank_details'
      get 'account'
      get 'profile_delete'
      get 'leave_application'
      post 'profile_delete'
      get 'profile_edit'
      get 'update_profile'
      post 'update_profile'
      post 'profile_edit'
      get 'destroy'
      get 'credentials'
      get 'download_bank_accounts'
      get 'approve_leave'
      get 'reject_leave'
    
    end
  end

  resources :profile do
    collection do
      get 'index'
      post 'index'
      post 'create'
      get 'destroy'
      get 'update'
      post 'update'
      
    end
  end

  resources :administration do
    collection do
      get 'index'
      post 'index'
      post 'create'
      get 'account'
      get 'destroy'
      get 'update'
      post 'update'
    end
  end    


end  