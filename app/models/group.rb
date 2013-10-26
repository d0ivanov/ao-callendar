class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :events, as: :eventable
  has_many :polls

  def join_user user
    users << user
  end
end