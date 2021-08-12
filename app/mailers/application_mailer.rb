# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'shahry@support.com'
  layout 'mailer'
end
