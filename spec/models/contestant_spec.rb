require 'rails_helper'

RSpec.describe Contestant, type: :model do
  it { should validate_presence_of(:name) }
  it { should allow_value('http://lorempixel.com/300/300').for(:img_url) }
  it { should allow_value(nil, '').for(:img_url) }
  it { should_not allow_value('hello').for(:img_url) }
end
