require 'rails_helper'

RSpec.describe Ballot, type: :model do
  it { should belong_to(:contestant1).class_name('Contestant') }
  it { should belong_to(:contestant2).class_name('Contestant') }
  it { should validate_presence_of(:contestant1) }
  it { should validate_presence_of(:contestant2) }

  describe '#votes' do
    it 'should return the number of votes for the given contestant id' do
      contestant = FactoryGirl.create(:contestant)
      ballot = FactoryGirl.create(:ballot, {
        contestant1: contestant,
        contestant1_votes: 50
      })

      expect(ballot.votes(contestant.id)).to eq 50
    end

    it 'should return nil if the contestant id isn\'t on the ballot' do
      contestant = FactoryGirl.create(:contestant)
      ballot = FactoryGirl.create(:ballot)

      expect(ballot.votes(contestant.id)).to be nil
    end
  end

  describe '#matches' do
    it 'should return the total matches that have taken place for that pair' do
      ballot = FactoryGirl.create(:ballot, {
        contestant1_votes: 50,
        contestant2_votes: 35
      })

      expect(ballot.matches).to eq 85
    end
  end

  describe '#winner' do
    it 'should return the model of winner' do
      ballot = FactoryGirl.create(:ballot, contestant1_votes: 100, contestant2_votes: 99)
      expect(ballot.winner).to be_a Contestant
      expect(ballot.winner).to eq ballot.contestant1
    end

    it 'should return nil if there\'s a tie' do
      ballot = FactoryGirl.create(:ballot, contestant1_votes: 100, contestant2_votes: 100)
      expect(ballot.winner).to eq nil
    end
  end

  describe '#tie?' do
    it 'should return true if the votes for each contestant are equal' do
      ballot = FactoryGirl.create(:ballot, contestant1_votes: 100, contestant2_votes: 100)
      expect(ballot.tie?).to eq true
    end

    it 'should return false if the votes for each contestant are not equal' do
      ballot = FactoryGirl.create(:ballot, contestant1_votes: 100, contestant2_votes: 99)
      expect(ballot.tie?).to eq false
    end
  end
end
