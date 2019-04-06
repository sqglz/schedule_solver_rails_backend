class ShiftRole < ApplicationRecord
  belongs_to :shift
  belongs_to :responsibility
end
