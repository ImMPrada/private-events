class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    if current_user.id == params[:id].to_i
      load_template_data
    else
      redirect_to events_path
    end
  end

  private

  def load_template_data
    @user = current_user
    @past_events = @user.created_events.expired + @user.attended_events.expired
    @future_events = @user.created_events.active + @user.attended_events.active
  end
end
