class ApplicationController < ActionController::Base

  def current_user
    @current_user = User.find(safe_user_params[:user_id])
  end

  private

  def safe_user_params
    params.require(:user).permit(:user_id)
  end
end
