class BaguMailMailer < ApplicationMailer
  default from: 'admin@bagukira.com'

  def project_invite_mail
    @email = params[:email]
    @unit = params[:unit]
    @user = params[:user]
    @url = "#{config.allowed_cors_origins}/projects/p/#{@unit.id}"
    mail(to: @email, subject: 'Invitation to contribute')
  end

  def user_mail
    @user = params[:user]
    mail(to: @user.email, subject: 'test')
  end

  def user_created_mail
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to BaguKira')
  end

  def user_updated_mail
    @user = params[:user]
    mail(to: @user.email, subject: 'Your BaguKira user account has been updated')
  end

  def user_destroyed_mail(_user)
    @user = params[:user]
    mail(to: @user.email, subject: 'Your BaguKira user account has been deleted')
  end
end
