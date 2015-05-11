# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

class Group < ActiveRecord::Base
  has_many :posts
  has_many :group_users
  has_many :members, :through => :group_users, :source => :group

  validates :title, presence: true

  belongs_to :owner, :class_name => 'User', :foreign_key => :user_id

  def editable_by?(user)
    user && user == owner
  end

end
