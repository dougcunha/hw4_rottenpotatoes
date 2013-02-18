require "spec_helper"
require "factories"

describe Movie do
  describe "Find movies by director 'Ridley Scott'" do
    it "should have a movies_by_director method" do
      Movie.respond_to?(:movies_by_director).should be_true
    end
    it 'should return all movies form director "Ridley Scott"' do
      spected = ['Blade Runner', 'Alien']
      [:star_wars, :blade_runner, :thx1138, :alien].each do |m|
        spected.insert(FactoryGirl.create(m))
      end
      movies = Movie.movies_by_director("Ridle Scott")
      movies.each { |m| m.director.should eq "Riddle Scott" }
    end

    it 'movie should have a instance method to return all movies from same director' do
      @movie = Movie.new();
      @movie.respond_to?(:movies_by_director).should be_true
    end
  end
end