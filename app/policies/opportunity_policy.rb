class OpportunityPolicy < Struct.new(:user, :opportunity)
  def show?
    (
      opportunity.posted? ||
      (
        user.try(:approver?) ||
        user.try(:admin?) ||
        (user.try(:staff?) && opportunity.created_by_user == user)
      )
    )
  end

  def post?
    user && user.permission_level_is_at_least?('staff')
  end

  def approve?
    user && user.permission_level_is_at_least?('approver')
  end
end
