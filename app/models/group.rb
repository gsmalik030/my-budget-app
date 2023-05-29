class Group < ApplicationRecord
    belongs_to :user
    has_many :entities, through: :group_entities
    validates :name, :icon, presence:true, length: {in: 1...500}
end
