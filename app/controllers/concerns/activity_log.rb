module ActivityLog
  def create_activity user_id,target_id,type_action
    Activity.create! user_id: user_id, target_id: target_id, type_action: type_action
  end
end
