class AsyncInfoController < ApplicationController

  def base_data
    flash.discard(:notice)
    unless user_signed_in?
      render json: nil
      return
    end
    @user = current_user
    respond_to do |format|
      format.json do
        render json: {
          user: user_data,
        }
      end
    end
  end

  def user_data
    Rails.cache.fetch(user_cache_key, expires_in: 15.minutes) do
      {
        id: @user.id,
        name: @user.name,
        username: @user.username,
        created_at: @user.created_at,
        admin: @user.admin?
      }
    end.to_json
  end

  def user_cache_key
    "user-info-#{current_user&.id}__
    #{current_user&.updated_at}__"
  end
end