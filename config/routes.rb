Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
	  namespace :v1 do
	   	resources :inbounds, only: [] do
	   		collection do
		   		post :sms
		   	end
	   	end
	   	resources :outbounds, only: [] do
	   		collection do
		   		post :sms
		   	end
	   	end
	  end
	 end
end
