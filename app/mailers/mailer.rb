class Mailer < ActionMailer::Base
  include BuildEmailAddressHelper
  helper FormattingHelper

  before_action { @include_subscription_preferences_link = true }

  layout 'base_mailer'

  def search_results(user, opportunity_ids)
    @opportunities = Opportunity.
                      where(id: opportunity_ids).
                      order_by_recently_posted

    build_email(user)
  end

  def question_asked(user, question)
    @question = question
    build_email(user)
  end

  def question_answered(user, question)
    @question = question
    build_email(user)
  end

  def approval_request(user, opportunity)
    @opportunity = opportunity
    @creator = opportunity.created_by_user

    build_email(
      user,
      subject: t(
        'mailer.approval_request.subject',
        creator: @creator.name,
        site_title: DispatchConfiguration.site_title
      ),
      reply_to: opportunity.created_by_user.email
    )
  end

  def question_deadline(user, opportunity)
    @opportunity = opportunity

    build_email(
      user,
      subject: t(
        'mailer.question_deadline.subject',
        opportunity: @opportunity.title
      )
    )
  end

  def submission_deadline(user, opportunity)
    @opportunity = opportunity

    build_email(
      user,
      subject: t(
        'mailer.submission_deadline.subject',
        opportunity: @opportunity.title
      )
    )
  end

  private

  def build_email(user, mail_params = {})
    @user = user
    mail_params[:from] ||= default_from_address
    mail_params[:to] ||= build_email_address(user.email, user.name)
    mail_params[:subject] ||= calculate_subject
    mail(mail_params)
  end

  def calculate_subject
    t(
      "mailer.#{action_name}.subject",
      site_title: DispatchConfiguration.site_title
    )
  end

  def default_from_address
    build_email_address(
      DispatchConfiguration.email_notification_from_address,
      DispatchConfiguration.site_title
    )
  end
end
