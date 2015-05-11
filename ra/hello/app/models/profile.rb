# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string(255)
#  birthday   :date
#  qq         :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Profile < ActiveRecord::Base
  belongs_to :user

  def owned_by?(user)
    user.is_a?(User) and user.id == user_id
  end
end
