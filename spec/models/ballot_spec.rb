require 'rails_helper'

RSpec.describe Ballot, type: :model do
  it { should belong_to(:contestant1).class_name('Contestant') }
  it { should belong_to(:contestant2).class_name('Contestant') }
  it { should validate_presence_of(:contestant1) }
  it { should validate_presence_of(:contestant2) }

  describe 'winner' do
    it 'should return the model of winner' do
      ballot = FactoryGirl.create(:ballot, contestant1_wins: 100, contestant2_wins: 99)
      expect(ballot.winner).to be_a Contestant
      expect(ballot.winner).to eq ballot.contestant1
    end

    it 'should return nil if there\'s a tie' do
      ballot = FactoryGirl.create(:ballot, contestant1_wins: 100, contestant2_wins: 100)
      expect(ballot.winner).to eq nil
    end
  end

  describe '#tie?' do
    it 'should return true if the wins for each contestant are equal' do
      ballot = FactoryGirl.create(:ballot, contestant1_wins: 100, contestant2_wins: 100)
      expect(ballot.tie?).to eq true
    end

    it 'should return false if the wins for each contestant are not equal' do
      ballot = FactoryGirl.create(:ballot, contestant1_wins: 100, contestant2_wins: 99)
      expect(ballot.tie?).to eq false
    end
  end
end
