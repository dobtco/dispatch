class OpportunityPolicy < Struct.new(:user, :opportunity)
  def show?
    opportunity.posted? ||
    opportunity_admin?
  end

  def edit?
    opportunity_admin?
  end

  def create?
    user && user.permission_level_is_at_least?('staff')
  end

  def approve?
    user && user.permission_level_is_at_least?('approver')
  end

  def submit?
    # Allow admins to see what their submission form will look like
    (opportunity_admin? || opportunity.open_for_submissions?)
  end

  def ask_question?
    user &&
    opportunity.open_for_questions?
  end

  def subscribe?
    show? &&
    user
  end

  def review_submissions?
    opportunity_admin?
  end

  def answer_questions?
    opportunity.enable_questions? &&
    opportunity_admin?
  end

  private

  def opportunity_admin?
    user.try(:approver?) ||
    user.try(:admin?) ||
    (user.try(:staff?) && opportunity.created_by_user == user)
  end
end
