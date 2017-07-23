class Ballot < ApplicationRecord
  belongs_to :contestant1, class_name: 'Contestant'
  belongs_to :contestant2, class_name: 'Contestant'

  validates :contestant1, presence: true
  validates :contestant2, presence: true

  def winner
    return nil if tie?
    contestant1_wins > contestant2_wins ? contestant1 : contestant2
  end

  def tie?
    (contestant1_wins == contestant2_wins)
  end
end
