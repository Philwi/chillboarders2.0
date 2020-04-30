Rails.application.routes.draw do
  root to: "landing#index"
  get '/:locale' => 'landing#index'

  localized do
    scope "/:locale" do
      devise_for :users, controllers: { registrations: 'user/registrations' }
    end
  end
end
