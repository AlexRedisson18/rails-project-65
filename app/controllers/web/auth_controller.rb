# frozen_string_literal: true

module Web
  class AuthController < Web::ApplicationController
    def callback
      user_data = request.env['omniauth.auth']['info']
      user = find_or_initialize_user(user_data)

      if user.save
        sign_in(user)
        flash[:notice] = t('auth.signed_in')
      else
        logger.debug "==== USER NOT SAVED: #{user.errors}"

        flash[:alert] = t('auth.error')
      end

      redirect_to root_path
    end

    def logout
      sign_out
      redirect_to root_path, notice: t('auth.signed_in')
    end

    private

    def find_or_initialize_user(user_data)
      user_email = user_data['email'].downcase
      user_name = user_data['name']

      logger.debug "==== USER_EMAIL: #{user_email}"
      logger.debug "==== USER_NAME: #{user_name}"

      user = User.find_or_initialize_by(email: user_email)
      user.name = user_name

      logger.debug "==== USER ATTRS: #{user.attributes.inspect}"
      logger.debug "==== USER VALID?: #{user.valid?}"

      user
    end
  end
end
