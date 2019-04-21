class ApplicationController < ActionController::Base

  helper_method :current_user, :current_business
  skip_before_action :verify_authenticity_token

  def current_user
    @current_user = User.last
  end
  def current_business
    @business = current_user.business
  end

  private

  def safe_user_params
    params.require(:user).permit(:user_id, :first_name, :last_name, :password, :password_confirmation, :email, :employment_start_date)
  end

  def safe_business_params
    params.require(:business).permit(:business_id)
  end
end
