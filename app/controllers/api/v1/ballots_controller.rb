class Api::V1::BallotsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def update
    data = JSON.parse(request.body.read)
    unless data.has_key? 'winner'
      return render json: { error: 'Invalid winner' }, status: 422
    end

    @ballot = Ballot.find(params[:id])
    if data['winner'] == 1
      @ballot.contestant1_votes += 1
      @ballot.save
    elsif data['winner'] == 2
      @ballot.contestant2_votes += 1
      @ballot.save
    else
      return render json: { error: 'Invalid winner' }, status: 422
    end
    render json: @ballot, adapter: :json
  end

  def random
    @ballot = Ballot.offset(rand(Ballot.count)).first
    render json: @ballot, adapter: :json
  end
end
