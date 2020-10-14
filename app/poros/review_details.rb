class ReviewDetails
  attr_reader :author,
              :url,
              :content

  def initialize(attr)
    @author = attr[:author]
    @url = attr[:url]
    @content = attr[:content]
    @id = attr[:id]
  end
end
