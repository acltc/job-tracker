class Lead < ApplicationRecord
  belongs_to :user
  has_many :statuses, dependent: :delete_all

  def current_step
    statuses.find_by(active: true).name
  end

  def progress_level
    statuses.find_by(active: true).progress_level
  end
end
