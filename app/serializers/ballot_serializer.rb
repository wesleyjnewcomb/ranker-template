class BallotSerializer < ActiveModel::Serializer
  attributes :id, :contestant1_votes, :contestant2_votes

  attribute :contestant1 do
    contestant1 = object.contestant1
    {
      id: contestant1.id,
      name: contestant1.name,
      img_url: contestant1.img_url
    }
  end

  attribute :contestant2 do
    contestant2 = object.contestant2
    {
      id: contestant2.id,
      name: contestant2.name,
      img_url: contestant2.img_url
    }
  end
end
