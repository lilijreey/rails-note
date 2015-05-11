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

class Article < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :comments

  validates_presence_of :title, :body

  scope :published, lambda { where('articles.publish_at IS NOT NULL')}
  scope :draft, lambda { where('articles.publish_at IS NULL')}
  scope :recent, lambda { published.where('articles.publish_at > ?', 1.week.ago.to_date)}
  scope :where_title, lambda { |term| where('articles.title LIKE ?', "%#{term}%")}

  def published?
    publish_at.persent?
  end

  def owned_by?(user)
    user.is_a?(User) and user.id == user_id
  end


end
