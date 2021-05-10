# frozen_string_literal: true

module AuthenticationHelpers
  def self.auth_headers(_user)
    token = ApplicationController.encode_token({ user_id: user.id })
    # Knock::AuthToken.new(payload: { sub: user.id }).token

    { Authorization: "Bearer #{token}" }
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelpers, type: %i[request controller]
end
