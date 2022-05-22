class HealthCheckController < ApplicationController
  def healthcheck
    render json: { message: "app is healthy" }, status: :ok
  end
end