# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Knock::Authenticable

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from ActiveRecord::DeleteRestrictionError, with: :handle_cant_destroy_dependents
  rescue_from ActionController::ParameterMissing, with: :handle_missing_parameters
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_parameters
  # rescue_from StandardError, with: :handle_uncaught_error

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

  def handle_cant_destroy_dependents(obj)
    render json: { errors: obj }, status: :forbidden
  end

  def handle_invalid_parameters(obj)
    render json: { errors: obj }, status: :unprocessable_entity
  end

  def handle_missing_parameters(obj)
    # { "controller": { "param": "value" } }
    render json: { errors: obj }, status: :bad_request
  end

  def handle_uncaught_error(obj)
    render json: { errors: obj }, status: :internal_server_error
  end
end
