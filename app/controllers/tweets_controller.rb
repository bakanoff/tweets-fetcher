class TweetsController < ApplicationController
  require 'will_paginate/array'

  def fetch
    @tweets = Rails.cache.read(params[:hashtag])
    if !@tweets
      @tweets = TweetCreator.call(params[:hashtag])
      @tweets = @tweets.sort_by{|e| e[:retweets_count]}.reverse
      Rails.cache.write(params[:hashtag], @tweets, expires_in: 15.minutes)
    end
    @tweets = @tweets.paginate(page: params[:page], per_page: 3)
    render 'tweets'
  end
end
