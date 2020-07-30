class ApplicationController < ActionController::API
  include Knock::Authenticable

  rescue_from RecordNotFound, with: :handle_not_found
  rescue_from DeleteRestrictionError, with: :handle_cant_destroy_dependents
  rescue_from ParameterMissing, with: :handle_missing_parameters
  rescue_from StandardError, with: :handle_uncaught_error

  # Valid 4hrs: change in config/initializers/knock.rb .token_lifetime
  def new_jwt
    Knock::AuthToken.new(payload: { sub: current_user.id }).token
  end

  def render(options = nil, extra_options = {}, &block)
    options ||= {}
    # User logged in? Send a new JWT with JSON response.
    options[:json][:jwt] = new_jwt if json_response?(options) && logged_in?
    # Unauthorised then
    super(options, extra_options, &block)
  end

  private

  def json_response?(options)
    options[:json].is_a?(Hash)
  end

  def logged_in?
    current_user.present?
  end

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

  def handle_uncaught_error(obj)
    render json: { errors: obj }, status: :internal_server_error
  end
end
