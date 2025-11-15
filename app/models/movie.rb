class Movie < ActiveRecord::Base
  # Returns the list of all MPAA ratings used in the app
  def self.all_ratings
    ["G", "PG", "PG-13", "R"]
  end

  # Returns an ActiveRecord::Relation filtered by the provided ratings list.
  # If ratings_list is nil or empty, returns all movies.
  def self.with_ratings(ratings_list)
    return all if ratings_list.nil? || ratings_list.empty?
    where(rating: ratings_list)
  end

  # Returns movies with the same director, excluding the current movie
  def others_by_same_director
    return Movie.none if director.blank?
    Movie.where(director: director).where.not(id: id)
  end
end

