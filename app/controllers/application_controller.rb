require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  private

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to new_user_registration_path, notice: 'Please sign up or log in to view that page!'
    end
  end
end
