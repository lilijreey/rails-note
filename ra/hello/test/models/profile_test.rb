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

require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
