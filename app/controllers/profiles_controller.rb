class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @past_events = @user.created_events.expired + @user.attended_events.expired
    @future_events = @user.created_events.active + @user.attended_events.active
  end
end
