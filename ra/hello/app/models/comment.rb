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

class Comment < ActiveRecord::Base
  belongs_to :article

  validates_presence_of :article_id, :name, :email, :body

  def article_should_be_published
    errors.add(:article_id, 'is not published yet') if article && !article.published?
  end
end
