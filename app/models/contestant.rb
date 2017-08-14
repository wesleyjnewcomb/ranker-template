class Contestant < ApplicationRecord
  validates :name, presence: true
  validates :img_url, :format => URI::regexp(%w(http https)), allow_blank: true


  def ballots
    Ballot.where(contestant1_id: id) + Ballot.where(contestant2_id: id)
  end

  def winning_ballots
    ballots.select { |b| b.winner.id == id }
  end

  def losing_ballots
    ballots.select { |b| b.winner.id != id unless b.tie? }
  end

  def votes
    votes = 0
    ballots.each { |b| votes += b.votes(id) }
    votes
  end

  def matches
    matches = 0
    ballots.each { |b| matches += b.matches }
    matches
  end
end
