require 'rails_helper'
RSpec.describe "Profiles endpoints", type: :request do
  context 'when there are no profiles registered' do
    it  'returns an empty list' do
      get '/api/v1/profiles'

      expect(JSON.parse(response.body)).to be_empty
    end
  end

  context 'when there are profiles' do
    before do
      Profile.create name: 'Maria', birth_date: '1999-12-26', genre: 'Female'
      Profile.create name: 'José', birth_date: '2000-02-05', genre: 'Male' 
    end  

    it 'returns 2 items' do
      get '/api/v1/profiles'

      expect(JSON.parse(response.body).count).to eq(2)
    end

    it  'returns a list' do
      get '/api/v1/profiles'

      expect(JSON.parse(response.body).map(&:symbolize_keys).first).to include(
        name: 'José',
        birth_date: '2000-02-05', 
        genre: 'Male'          
      )

      expect(JSON.parse(response.body).map(&:symbolize_keys).last).to include(
        name: 'Maria',
        birth_date: '1999-12-26', 
        genre: 'Female'          
      )
    end
  end
end
