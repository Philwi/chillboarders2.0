Rails.application.routes.draw do
  root to: "spots#index"
  get '/:locale' => 'landing#index'

  localized do
    scope "/:locale" do
      devise_for :users, controllers: { registrations: 'user/registrations' }

      resources :spots, only: [:index, :new, :create, :edit, :update]

      resources :comments, only: [:create]
    end
  end
end
