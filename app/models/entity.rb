class Entity < ApplicationRecord
  belongs_to :user
  has_many :group_entities, dependent: :destroy
  has_many :groups, through: :group_entities

  validates :name, :amount, presence: true, length: { in: 1...500 }
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
end
