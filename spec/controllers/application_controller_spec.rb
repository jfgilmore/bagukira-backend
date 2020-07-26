require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe 'error handling' do
    # it { should rescue_from(StandardError).with(:handle_uncaught_error) }
    it { should rescue_from(ActiveRecord::RecordNotFound).with(:handle_not_found) }
    it { should rescue_from(ActiveRecord::DeleteRestrictionError).with(:handle_cant_destroy_dependents) }
    # it { should rescue_from(ActionController::ParameterMissing).with(:handle_missing_parameters) }
    it { should { respond_with(:forbidden) || respond_with(:not_found) || respond_with(:internal_server_error) } }
  end
end
