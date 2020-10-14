class MovieCreator
  attr_reader :title,
              :vote_average,
              :release_date,
              :genres,
              :runtime,
              :overview,
              :name,
              :character,
              :author,
              :url,
              :content,
              :id

  def initialize(attr)
    @title = attr[:title]
    @vote_average = attr[:vote_average]
    @release_date = attr[:release_date]
    @genres = attr[:genres]
    @runtime = attr[:runtime]
    @overview = attr[:overview]
    @name = attr[:name]
    @character = attr[:character]
    @author = attr[:author]
    @url = attr[:url]
    @content = attr[:content]
    @id = attr[:id]
  end

  # def release_year(date)
  #   if release_date != ''
  #     Date.parse(release_date).year
  #   else
  #     return 'n/a'
  #   end
  # end

  # def total_runtime(runtime)
  #   hours = runtime / 60
  #   remaining = runtime % 60
  #   "#{hours}h #{remaining}m"
  # end

  # def first_ten_cast(cast_array)
  #   require 'pry'; binding.pry
  #   cast_array[0..9].map do |cast|
  #     "#{cast.name} as #{cast.character}"
  #   end
  # end

  # def display_genres(genre_array)
  #   genre_array.map do |genre|
  #     genre[:name]
  #   end
  # end
end
