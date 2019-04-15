# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end



#   def sign_in_with(provider_name)
#     @user = User.from_omniauth(request.env["omniauth.auth"])
#     sign_in_and_redirect @user, :event => :authentication
#     set_flash_message(:notice, :success, :kind => provider_name) if is_navigational_format?
# end
# def google_oauth2
#   sign_in_with "Google"
# end

# def facebook
#   sign_in_with "facebook"
# end

# end


def facebook
  # You need to implement the method below in your model (e.g. app/models/user.rb)
  @user = User.from_omniauth(request.env["omniauth.auth"])

  if @user.persisted?
    sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
    set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
  else
    session["devise.facebook_data"] = request.env["omniauth.auth"]
    redirect_to new_user_registration_url
  end
end

def failure
  redirect_to root_path
end







def self.from_omniauth(access_token)
  data = access_token.info
  user = User.where(email: data['email']).first

  # Uncomment the section below if you want users to be created if they don't exist
  # unless user
  #     user = User.create(name: data['name'],
  #        email: data['email'],
  #        password: Devise.friendly_token[0,20]
  #     )
  # end
  user
end


def twitter
  # You need to implement the method below in your model (e.g. app/models/user.rb)
  @user = User.from_omniauth(request.env["omniauth.auth"])

  if @user.persisted?
    sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
    set_flash_message(:notice, :success, kind: "Twitter") if is_navigational_format?
  else
    session["devise.twitter_data"] = request.env["omniauth.auth"]
    redirect_to new_user_registration_url
  end
end

def failure
  redirect_to root_path
end

def linkedin
  # You need to implement the method below in your model (e.g. app/models/user.rb)
  @user = User.from_omniauth(request.env["omniauth.auth"])

  if @user.persisted?
    sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
    set_flash_message(:notice, :success, kind: "Linkedin") if is_navigational_format?
  else
    session["devise.linkedin_data"] = request.env["omniauth.auth"]
    redirect_to new_user_registration_url
  end
end

def failure
  redirect_to root_path
end




def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
end



end
