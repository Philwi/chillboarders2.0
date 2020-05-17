# frozen_string_literal: true

class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @model = User::Operation::Create::Present.(params: nil)['model']
    render html: cell(User::Cell::Create, @model), layout: 'application'
  end

  # POST /resource
  def create
    result = User::Operation::Create.call(params: params.permit!)
    if result.success?
      sign_up(resource_name, result['model'])
      return redirect_to root_path
    else
      render cell(User::Cell::Create, result['contract.default'])
    end
  end

  # GET /resource/edit
  def edit
    @model = User::Operation::Update::Present.(params: nil, user: current_user)['model']
    render html: cell(User::Cell::Edit, @model), layout: 'application'
  end

  # PUT /resource
  def update
    result = User::Operation::Update.call(params: params.permit!, user: current_user)
    if result.success?
      sign_up(resource_name, result['model'])
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?
      respond_with resource, location: user_site_path(result['model'].user_site)
    else
      render cell(User::Cell::Edit, result['contract.default'])
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
end
