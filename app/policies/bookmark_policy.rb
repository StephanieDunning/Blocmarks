class BookmarkPolicy < ApplicationPolicy
  def create?
    user.present?
  end
  
  def update?
    user.present? && (record.topic.user == user)
  end

  def destroy?
    user.present? && (record.topic.user == user)
  end
end
