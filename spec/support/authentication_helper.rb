# frozen_string_literal: true

module AuthenticationHelpers
  def self.auth_headers(user)
    token = Knock::AuthToken.new(payload: { sub: user.id }).token

    { Authorization: "Bearer #{token}" }
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelpers, type: %i[request controller]
end
