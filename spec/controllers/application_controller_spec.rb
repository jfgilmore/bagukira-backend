require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe 'shared methods' do
    it { should rescue_from(ActiveRecord::RecordNotFound).with(:handle_not_found) }
  end
end
