class ProfilesController < ApplicationController
  def show
    @user = User.with_role(:admin).first
  end
end