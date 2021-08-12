# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'kottenora@support.com'
  layout 'mailer'
end
