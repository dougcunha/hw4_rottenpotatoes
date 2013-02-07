require "rspec"
require "spec_helper"


describe MoviesController do
  describe "Find Movies With Same Director" do

    it "should do call the model method that performs movies search by director" do
      Movie.should_receive(:movies_by_director).with('Ridley Scott')
      post :movies_by_director, {:director => 'Ridley Scott'}
    end
    it "shoult select the Director Movies template for rendering" do
      Movie.stub(:movies_by_director)
      post :movies_by_director, {:director => 'Ridley Scott'}
      response.should render_template('movies_by_director')
    end
    it "shoult make the search result available to that tamplate" do
      fake_results = [mock('Movie'), mock('Movie')]
      Movie.stub(:movies_by_director).and_return(fake_results)
      post :movies_by_director, {:director => 'Ridley Scott'}

      assigns(:movies).should == fake_results
    end

  end
end