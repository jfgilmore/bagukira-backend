# Preview all emails at http://localhost:8080/rails/mailers/bagu_mail
class BaguMailPreview < ActionMailer::Preview
  def user_mail_preview
    BaguMailMailer.with({ user: User.first, email: 'test@email.com', unit: Unit.last }).project_invite_mail
  end
end
