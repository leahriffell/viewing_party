class RecommendationDetails
  attr_reader :title,
              :id

  def initialize(attr)
    @title = attr[:title]
    @id = attr[:id]
  end
end
