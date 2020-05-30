Rails.application.routes.draw do
  root to: "spots#index"
  get '/:locale' => 'spots#index'

  localized do
    scope "/:locale" do
      devise_for :users, controllers: { registrations: 'user/registrations' }

      resources :spots, only: [:index, :new, :create, :edit, :update]
      resources :comments, only: [:create]

      resources :rss_feeds, only: [:index]

      # without params[:id]
      resource :user_sites do
        get :edit
        get :index
        patch :update
        get :modal_content
        get :modal_close
      end

      resources :settings, only: [:index]
      resources :user_sites, only: [:show]
      resources :user_messages, only: [:create, :update]
    end
  end
end
