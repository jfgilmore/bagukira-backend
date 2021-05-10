# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'info@bagukira.com'
  layout 'mailer'
end
