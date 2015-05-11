# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  article_id :integer
#  name       :string(255)
#  email      :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
