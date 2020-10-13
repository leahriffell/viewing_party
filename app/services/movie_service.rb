class MovieService

  def self.keyword_search(page_num, keywords)
    response = keyword_search_endpoint(page_num, keywords)
    parse(response)
  end

  def self.top_movies(page_num)
    response = top_movies_endpoint(page_num)
    parse(response)
  end

private

  def self.language(language)
      "language=#{language}"
  end

  def self.exclude_adult
      'include_adult=false'
  end

  def self.movies_api_key
      ENV['MOVIES_API_KEY']
  end

  def self.conn
      Faraday.new(url: "https://api.themoviedb.org")
  end

  def self.parse(response)
      JSON.parse(response.body, symbolize_names: true)
  end

    def self.top_movies_endpoint(page_num)
      sort_by = 'vote_average.desc'
      conn.get("3/discover/movie?api_key=#{movies_api_key}&#{language('en-US')}&sort_by=#{sort_by}&#{exclude_adult}&page=#{page_num}&vote_count.gte=300")
  end

  def self.keyword_search_endpoint(page_num, keywords)
      conn.get("3/search/movie?api_key=#{movies_api_key}&#{language('en-US')}&#{exclude_adult}&page=#{page_num}&query=#{keywords}")
  end


end