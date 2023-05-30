class Group < ApplicationRecord
  belongs_to :user
  has_many :group_entities, dependent: :destroy
  has_many :entities, through: :group_entities
  validates :name, :icon, presence: true
end
