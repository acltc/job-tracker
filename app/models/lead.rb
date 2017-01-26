class Lead < ApplicationRecord
  belongs_to :user
  has_many :statuses, dependent: :delete_all

  def current_step
    if statuses.any?
      statuses.find_by(active: true).name
    end
  end

  def progress_level
    if statuses.any?
      statuses.find_by(active: true).progress_level
    else
      return 0
    end
  end
end
