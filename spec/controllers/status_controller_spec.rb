# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StatusController do
  it { should use_before_action :authenticate_user }
end
