class RecommendationDetails
  attr_reader :title

  def initialize(attr)
    @title = attr[:title]
    @id = attr[:id]
  end
end
