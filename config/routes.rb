class ReservedEndpointConstraint
  def matches?(request)
    RESERVED_SHORT_NAMES.each do |ep|
      if request.path.start_with?("/#{ep}/")
        return false
      end
    end
    true
  end
end

Goto::Application.routes.draw do
  match '/auth/google_oauth2/callback', to: 'sessions#create'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  resources :links
  root :to => 'links#index'
  match '*link' => 'links#redirect', :constraints => ReservedEndpointConstraint.new
end
