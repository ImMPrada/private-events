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
    @past_events = @user.created_events.past + @user.attended_events.past
    @future_events = @user.created_events.future + @user.attended_events.future
  end
end
