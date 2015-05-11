# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  location   :string(255)
#  excerpt    :string(255)
#  body       :text
#  publish_at :datetime
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
