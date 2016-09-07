class HomeController < ApplicationController
  def index
  end

  def search
    provider = SearchProvider.new
    if provider.match params[:search_text]
      aw = Concurrent::Promise.execute do
        @availability_aw = provider.search_aw params[:search_text]
      end
      thw = Concurrent::Promise.execute do
        @availability_thw = provider.search_thw params[:search_text]
      end
      loop do
        break if aw.fulfilled? && thw.fulfilled?
        #waiting till both results are fetched
      end
    else
      @invalid = true
    end
  end
end
