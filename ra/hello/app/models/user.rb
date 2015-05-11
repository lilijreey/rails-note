# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  admin           :boolean
#

class User < ActiveRecord::Base
  has_secure_password
  has_one :profile
  has_many :articles, -> { order('publish_at DESC, title ASC')},
                     :dependent => :destroy

  has_many :replies, :through => :articles, :source => :comments


  validates_uniqueness_of :email
  validates_length_of :email, :within => 5..40
  #validates_format_of :email, :with => '/^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i'

  validates_confirmation_of :password

  def is_admin?
    return admin
  end


end
