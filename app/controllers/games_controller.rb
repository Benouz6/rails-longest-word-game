require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = ('a'..'z').to_a.sample(11)
  end

  def score
    @word = params[:word]

    if @word.include?(@letters.to_s)
      @answer = "#{@word} doesn't contain the good letters"
    elsif english_word?(@word)
      @answer = "#{@word} is a correct word"
    # elsif
    # Word is not found in the api

    else
      @answer = "Sorry but #{@word} is an unvalid english word"
    end
  end

private

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
