require 'rails_helper'

RSpec.describe Api::V1::BallotsController, type: :controller do
  describe 'PATCH#update' do
    let!(:ballot) { FactoryGirl.create(:ballot) }
    let(:request1) { { winner: 1 } }
    let(:request2) { { winner: 2 } }
    context 'when the request provides valid winner data' do
      it 'responds with 200 with a valid request' do
        patch :update, params: { id: ballot.id }, body: request1.to_json
        expect(response.status).to eq 200
      end

      it 'increments the votes for contestant1 if winner is 1' do
        ballot_id = ballot.id
        contestant1_votes = ballot.contestant1_votes

        patch :update, params: { id: ballot_id }, body: request1.to_json
        ballot = Ballot.find(ballot_id)
        expect(ballot.contestant1_votes).to eq(contestant1_votes + 1)
      end

      it 'updates the votes for contestant2 if winner is 2' do
        ballot_id = ballot.id
        contestant2_votes = ballot.contestant2_votes

        patch :update, params: { id: ballot_id }, body: request2.to_json
        ballot = Ballot.find(ballot_id)
        expect(ballot.contestant2_votes).to eq(contestant2_votes + 1)
      end

      it 'does not increment the loser\'s votes' do
        ballot_id = ballot.id
        contestant2_votes = ballot.contestant2_votes

        patch :update, params: { id: ballot_id }, body: request1.to_json
        ballot = Ballot.find(ballot_id)
        expect(ballot.contestant2_votes).to eq(contestant2_votes)
      end

      it 'responds with a JSON of the updated ballot' do
        ballot_id = ballot.id

        patch :update, params: { id: ballot_id }, body: request1.to_json
        ballot = Ballot.find(ballot_id)
        json = JSON.parse(response.body)
        expect(json).to match({
          'ballot' => {
            'id' => ballot.id,
            'contestant1' => {
              'id' => ballot.contestant1.id,
              'name' => ballot.contestant1.name,
              'img_url' => ballot.contestant1.img_url
            },
            'contestant2' => {
              'id' => ballot.contestant2.id,
              'name' => ballot.contestant2.name,
              'img_url' => ballot.contestant2.img_url
            },
            'contestant1_votes' => ballot.contestant1_votes,
            'contestant2_votes' => ballot.contestant2_votes
          }
        })
      end
    end

    context 'request provides invalid data' do
      let!(:ballot) { FactoryGirl.create(:ballot) }
      let(:bad_data) { { winer: 'cat' } }
      let(:bad_winner) { { winner: 3 } }

      it 'responds with 422 if given a bad data' do
        patch :update, params: { id: ballot.id }, body: bad_data.to_json

        expect(response.status).to eq 422
      end

      it 'responds with 422 if given a bad winner' do
        patch :update, params: { id: ballot.id }, body: bad_winner.to_json

        expect(response.status).to eq 422
      end
    end
  end

  describe 'GET#random' do
    it 'responds with 200' do
      get :random

      expect(response.status).to eq 200
    end
    it 'returns a random ballot' do
      ballots = FactoryGirl.create_list(:ballot, 20)
      get :random
      json = JSON.parse(response.body)
      expect(json).to have_key 'ballot'

      ballot_ids = ballots.map { |b| b.id }
      expect(ballot_ids).to include json['ballot']['id']
    end
  end
end
