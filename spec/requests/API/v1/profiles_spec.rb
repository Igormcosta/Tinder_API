require 'rails_helper'
RSpec.describe "Profiles endpoints", type: :request do
  context 'GET index' do
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
    

      it 'returns the correct HTTP status' do
        get '/api/v1/profiles'

        expect(response).to have_http_status(:ok)
      end

      it 'returns the correct content_type' do
        get '/api/v1/profiles'
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  context 'POST create' do
    it 'creates a post' do
      expect do
        post '/api/v1/profiles', params: {
          profile: {
            name: 'Maria',
            birth_date: '1999-12-26',
            genre: 'Female'
          }
        }
      end.to change(Profile, :count).by(1)
    end

    it 'returns the correct HTTP status' do
      post '/api/v1/profiles', params: {
        profile: attributes_for(:profile)
      }

      expect(response).to have_http_status(:created)
    end

    it 'returns the correct content_type' do
      post '/api/v1/profiles', params: {
        profile: attributes_for(:profile)
      }

      expect(response.content_type).to eq('application/json')
    end
  end
end
