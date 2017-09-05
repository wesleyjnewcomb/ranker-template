require 'rails_helper'

RSpec.describe ReactPagesController, type: :controller do
  describe 'GET#vote' do
    it 'renders the vote view' do
      get :vote
      expect(response).to render_template(:vote)
    end
  end

  describe 'GET#ladder' do
    it 'renders the ladder view' do
      get :ladder
      expect(response).to render_template(:ladder)
    end
  end
end
