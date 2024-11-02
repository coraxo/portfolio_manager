class CookiesController < ApplicationController
  def index
    #session[:cookie_consent] = nil
  end

  def consent
    session[:cookie_consent] = params[:cookies] if params[:cookies].present?
  end

  def reset_consent
    session[:cookie_consent] = nil
    redirect_to cookie_consent_path
  end
end
