# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  skip_before_action :authenticate_user!
  before_action :check_guest, only: %i[update destroy]
  before_action :default_image, only: %i[create update]
  
  # GET /resource/sign_up
  # def new
  #   @code = Code.all
  # end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :likes_count, :birth_ym, :work_idt, :work_ocpn, :gender, :image])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :birth_ym, :work_idt, :work_ocpn, :gender, :image])
  end

  def check_guest
    if resource.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません。'
    end
  end

  def default_image
    if !self.image.attached?
      self.image.attach(io: File.open(Rails.root.join('app/assets/images/no_image.png')), filename: 'no_image.png', content_type: 'image/png')
    end
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   redirect_to(posts_path)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
