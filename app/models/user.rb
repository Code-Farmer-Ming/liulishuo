class User < ActiveRecord::Base
  include Auth
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :follows
  has_many :follow_users, :class_name => "User", through: :follows, source: :follow

  has_many :followers, :class_name => "Follow", foreign_key: :follow_id
  has_many :follower_users, :class_name => "User", through: :followers

  has_many :followed_descs,class_name: "History",through: :follow_users, source: :histories

  has_many :histories

  before_save :update_history

  private

  def update_history
    if changed_attributes.has_key?(:desc) && self.desc.present?
      histories.create(desc: desc)
    end
  end
end
