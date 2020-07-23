class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  # rescue_from NoMethodError, with:
  rescue_from ActiveRecord::DeleteRestrictionError, with: :handle_cant_destroy_dependents

  private

  def handle_cant_destroy_dependents
    render json: { errors: {
      error: 'This unit has dependents, delete all it\'s dependents before you can delete the unit itself.'
    } }, status: :forbidden
  end

  def handle_not_found
    render json: {}, status: :not_found
  end
end
