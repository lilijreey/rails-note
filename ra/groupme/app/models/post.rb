# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  content    :text
#  group_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  belongs_to :group
  belongs_to :author, class_name: 'User', foreign_key: :user_id

  validates :content, :presence => true

  def editable_by?(user)
    user && user == author ##author where?
  end


end
