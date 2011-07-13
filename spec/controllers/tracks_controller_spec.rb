require 'spec_helper'

describe TracksController do
  def valid_attributes
    {
      :name => 'Mega song'
    }
  end

  describe 'GET show' do
    it 'assigns the requested track as @track' do
      track = Track.create! valid_attributes
      get :show, :id => track.id.to_s
      assigns[:track].should == track
    end
  end
end
