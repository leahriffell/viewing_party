class MovieFacade

    def self.top_movies_endpoint(page_num)
        sort_by = 'vote_average.desc'
        conn.get("3/discover/movie?api_key=#{movies_api_key}&#{language('en-US')}&sort_by=#{sort_by}&#{exclude_adult}&page=#{page_num}&vote_count.gte=300")
    end

    def self.keyword_search_endpoint(page_num, keywords)
        conn.get("3/search/movie?api_key=#{movies_api_key}&#{language('en-US')}&#{exclude_adult}&page=#{page_num}&query=#{keywords}")
    end

    def self.keyword_search(keywords)
        response1 = keyword_search_endpoint(1, keywords)
        response2 = keyword_search_endpoint(2, keywords)

        json1 = parse(response1)
        json2 = parse(response2)
        movies1 = json1[:results].map do |movie_data|
            MovieCreator.new(movie_data)
        end
        movies2 = json2[:results].map do |movie_data|
            MovieCreator.new(movie_data)
        end
        (movies1.concat(movies2)).flatten
    end

    def self.top_movies
        response1 = top_movies_endpoint(1)
        response2 = top_movies_endpoint(2)

        json1 = parse(response1)
        json2 = parse(response2)
        movies1 = json1[:results].map do |movie_data|
            MovieCreator.new(movie_data)
        end
        movies2 = json2[:results].map do |movie_data|
            MovieCreator.new(movie_data)
        end
        (movies1.concat(movies2)).flatten
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
end