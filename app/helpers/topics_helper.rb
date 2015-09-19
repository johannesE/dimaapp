module TopicsHelper

  def is_current_user_author?(topic)
    current_user == topic.user
  end
end
