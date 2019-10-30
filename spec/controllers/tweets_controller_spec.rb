require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
  let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) } 
  let(:cache) { Rails.cache }
  let(:tweet_data) {
        [{'user_name' => 'name',
        'tweet_text' => 'text',
        'retweets_count'=> '10',
        'url' => 'some.url' }]
      }
  
  before do
    allow(Rails).to receive(:cache).and_return(memory_store)
    Rails.cache.clear
  end
  
  it 'test caching' do
    expect(cache.exist?('non_existed_key')).to be(false)
    
    cache.write('existed_key', 'test')
    
    expect(cache.exist?('existed_key')).to be(true)
  end

  describe "#fetch" do
    let(:params) { {'hashtag' => 'cat'} }

    context "render view successful" do
      before do
        allow(TweetCreator).to receive(:new) {
          -> { tweet_data }
        }
        cache.write('cat', tweet_data)
      end
      render_views


      it "returns a correct status code" do
        get :fetch, params: params
        expect(response.status).to eq 200
      end

      it "render a correct view" do
        get :fetch, params: params
        expect(response.body).to match('<title>TweetsFetcher</title>')
      end
    end
  end
end
