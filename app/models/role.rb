class Role < ApplicationRecord
has_many :users

scope :veterinary, -> { where(rol_name: 'veterinario').limit(1).pluck(:id).first }
 scope :for_user, -> { limit(2) }
end
