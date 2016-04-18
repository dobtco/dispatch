class OpportunityPolicy < Struct.new(:user, :opportunity)
  def post?
    user && user.permission_level_is_at_least?('staff')
  end

  def approve?
    user && user.permission_level_is_at_least?('approver')
  end
end
