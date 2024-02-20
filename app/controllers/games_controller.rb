require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    characters = ('A'..'Z').to_a.shuffle
    random = rand(8..10)
    @grid = Array.new(random) { ("A".."Z").to_a.sample }
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    json_data = URI.open(url).read
    data = JSON.parse(json_data)
    word_check = data["found"]

    @word = params[:word]
    @grid = params[:grid].downcase

    if @word.chars.all? { |char| @word.chars.count(char) <= @grid.count(char) }
      if word_check
        @display_result = "Congratulations! #{params[:word]} is a valid English word!"
      else
        @display_result = "Sorry but #{params[:word]} does not seem to be a valid English word..."
      end
    else
      @display_result = "Sorry but #{params[:word]} can't be built out of #{@grid.upcase.split.join(', ')}"
    end
  end

end
