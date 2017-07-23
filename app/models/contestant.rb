class Contestant < ApplicationRecord
  validates :name, presence: true
  validates :img_url, :format => URI::regexp(%w(http https)), allow_blank: true
end
