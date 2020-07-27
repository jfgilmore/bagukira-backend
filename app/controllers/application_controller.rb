class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from ActiveRecord::DeleteRestrictionError, with: :handle_cant_destroy_dependents
  # rescue_from ActionController::ParameterMissing, with: :handle_missing_parameters
  # rescue_from StandardError, with: :handle_uncaught_error

  private

  def handle_not_found
    render json: {}, status: :not_found
  end

  def handle_cant_destroy_dependents
    render json: {
      error: 'This unit has dependents, delete all it\'s dependents before you can delete the unit itself.'
    }, status: :forbidden
  end

  def handle_missing_parameters
    render json: {
      error: 'Misformed request format { "controller": { "param": "value" } }.'
    }, status: :forbidden
  end

  # def handle_uncaught_error(obj)
  #   render json: { errors: obj }, status: :internal_server_error
  # end
end
