class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  def self.movies_by_director(director)
    self.find_all_by_director director
  end
  def movies_by_director(director)
    Movie.movies_by_director director
  end
end
