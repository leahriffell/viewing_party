class MovieCreator
  attr_reader :title,
              :vote_average,
              :id

  def initialize(attr)
    @title = attr[:title]
    @vote_average = attr[:vote_average]
    @id = attr[:id]
  end
end
