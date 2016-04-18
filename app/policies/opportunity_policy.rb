class OpportunityPolicy < Struct.new(:user, :opportunity)
  def approve?
    user.try(:approver?)
  end
end
