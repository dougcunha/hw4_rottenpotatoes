require 'spec_helper'


describe MoviesController do
  describe 'add director to existing movie, and  fill in "Director" with "Ridley Scott"' do
    it 'should call update_attributes and redirect" ' do
      movie = mock(Movie, :title => 'Alien', :id => '4')
      Movie.stub(:find).with('4').and_return(movie)
      movie.stub(:update_attributes!).and_return(true)
      put :update, {:id => '4', :movie => movie}
      response.should redirect_to(movie_path(movie))
    end
  end
  describe 'Find Movies With Same Director' do
    it 'should do call the model method that performs movies search by director' do
      Movie.should_receive(:movies_by_director).with('Ridley Scott')
      post :movies_by_director, {:director => 'Ridley Scott'}
    end

    it 'should select the Director Movies template for rendering' do
      Movie.stub(:movies_by_director)
      post :movies_by_director, {:director => 'Ridley Scott'}
      response.should render_template('movies_by_director')
    end

    it 'should make the search result available to that tamplate' do
      fake_results = [mock('Movie'), mock('Movie')]
      Movie.stub(:movies_by_director).and_return(fake_results)
      post :movies_by_director, {:director => 'Ridley Scott'}

      assigns(:movies).should == fake_results
    end

    it 'should redirect to movies if movie has no director' do
      movie = mock(Movie, :title => 'Alien', :id => '4')
      post :movies_by_director, {:director => ''}
      response.should redirect_to(movies_path())
    end

    it 'should return info has no director info to render view' do
      movie = mock(Movie, :title => 'Alien', :id => '4')
      post :movies_by_director, {:director => '', :movie => movie.title}
      flash[:notice].should == '\'Alien\' has no director info'
    end

  end
end