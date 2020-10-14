class CastDetails
  attr_reader :name,
              :character

  def initialize(attr)
    @name = attr[:name]
    @character = attr[:character]
    @id = attr[:id]
  end


end