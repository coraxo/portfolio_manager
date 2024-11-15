class CookiesController < ApplicationController
  allow_unauthenticated_access

  def index
  end

  def consent
    session[:cookie_consent] = params[:cookies] if params[:cookies].present?
  end

  def reset_consent
    session[:cookie_consent] = nil
    redirect_to cookie_consent_path
  end
end
