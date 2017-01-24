class Lead < ApplicationRecord
  belongs_to :user
  has_many :statuses, dependent: :delete_all
end
