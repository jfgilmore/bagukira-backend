# frozen_string_literal: true

class ApplicationController < ActionController::API
  # include Knock::Authenticable
  before_action :authorized

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from ActiveRecord::DeleteRestrictionError, with: :handle_cant_destroy_dependents
  rescue_from ActionController::ParameterMissing, with: :handle_missing_parameters
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_parameters
  # rescue_from StandardError, with: :handle_uncaught_error

  # Valid 4hrs: change in config/initializers/knock.rb .token_lifetime
  def new_jwt
    encode_token(payload: { sub: current_user.id }).token
  end

  def render(options = nil, extra_options = {}, &block)
    options ||= {}
    # User logged in? Send a new JWT with JSON response.
    options[:json][:jwt] = new_jwt if json_response?(options) && logged_in?
    # Unauthorised then
    super(options, extra_options, &block)
  end

  # starts -----------------------------------------------

  def encode_token(payload)
    private_key = RbNaCl::SimpleBox
    @public_key = private_key.verify_key
    JWT.encode payload, private_key, 'ED25519'
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def authorized
    render json: {}, status: :unauthorized unless logged_in?
  end

  def current_user
    user_id = decoded_token[0]['user_id']
    @user = User.find_by(id: user_id)
  end

  def decoded_token
    if auth_header
      token_from_request_headers
    else
      begin
        JWT.decode token, @public_key, true, algorithm: 'ED25519'
      rescue JWT::DecodeError
        nil
      end
    end
  end

  private

  def logged_in?
    !!current_user
  end

  def token
    params[:token] || token_from_request_headers
  end

  def token_from_request_headers
    auth_header.split(' ')[1]
  end

  # ends -------------------------------------------------

  def json_response?(options)
    options[:json].is_a?(Hash)
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
