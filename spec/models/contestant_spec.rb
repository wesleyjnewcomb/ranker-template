require 'rails_helper'

RSpec.describe Contestant, type: :model do
  it { should validate_presence_of(:name) }
  it { should allow_value('http://lorempixel.com/300/300').for(:img_url) }
  it { should allow_value(nil, '').for(:img_url) }
  it { should_not allow_value('hello').for(:img_url) }

  let(:contestant) { FactoryGirl.create(:contestant) }
  let(:ballots1_win) do
     FactoryGirl.create_list(:ballot, 5, {
       contestant1_id: contestant.id,
       contestant1_votes: 2,
       contestant2_votes: 1
     })
  end
  let(:ballots2_win) do
    FactoryGirl.create_list(:ballot, 5, {
      contestant2_id: contestant.id,
      contestant1_votes: 1,
      contestant2_votes: 2
      })
  end
  let(:ballots1_lose) do
    FactoryGirl.create_list(:ballot, 5, {
      contestant1_id: contestant.id,
      contestant1_votes: 1,
      contestant2_votes: 2
      })
  end
  let(:ballots2_lose) do
    FactoryGirl.create_list(:ballot, 5, {
      contestant2_id: contestant.id,
      contestant1_votes: 2,
      contestant2_votes: 1
      })
  end

  describe '#ballots' do
    it 'should return all the ballots for the contestant' do
      all_ballots = (ballots1_win + ballots2_win + ballots1_lose + ballots2_lose)

      expect(contestant.ballots.sort).to eq all_ballots.sort
    end
  end

  describe '#matches' do
    it 'should return the number of matches the contestant has been in' do
      all_ballots = (ballots1_win + ballots2_win + ballots1_lose + ballots2_lose)

      expect(contestant.matches).to eq 60
    end
  end

  describe '#votes' do
    it 'should return the total number of votes the contestant has received' do
      all_ballots = (ballots1_win + ballots2_win + ballots1_lose + ballots2_lose)

      expect(contestant.votes).to eq 30
    end
  end

  describe '#winning_ballots' do
    it 'should return only the ballots' do
      winning_ballots = (ballots1_win + ballots2_win).sort
      expect(contestant.winning_ballots.sort).to eq winning_ballots
    end
  end

  describe '#losing_ballots' do
    it 'should return only the losing ballots' do
      losing_ballots = (ballots1_lose + ballots2_lose).sort
      expect(contestant.losing_ballots.sort).to eq losing_ballots
    end
  end
end
