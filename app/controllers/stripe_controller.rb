class StripeController < ApplicationController

  def connect
    session[:return_to] = request.referer
    redirect_to StripeOauth.new(current_user).oauth_url
  end

  def confirm
    if params[:code]
      StripeOauth.new(current_user).verify!(params[:code])
    elsif params[:error]
      params[:error_description]
    end
    redirect_to session.delete(:return_to) || root_path
  end
end
