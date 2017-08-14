class Ballot < ApplicationRecord
  belongs_to :contestant1, class_name: 'Contestant'
  belongs_to :contestant2, class_name: 'Contestant'

  validates :contestant1, presence: true
  validates :contestant2, presence: true

  def votes(id)
    if id == contestant1_id
      contestant1_votes
    elsif id == contestant2_id
      contestant2_votes
    else
      nil
    end
  end

  def matches
    contestant1_votes + contestant2_votes
  end

  def winner
    return nil if tie?
    contestant1_votes > contestant2_votes ? contestant1 : contestant2
  end

  def tie?
    (contestant1_votes == contestant2_votes)
  end
end
