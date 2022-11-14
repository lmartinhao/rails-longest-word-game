require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(9)
  end

  def english_word
    word_dictionary = open("https://wagon-dictionary.herokuapp.com/#{@answer}")
    word = JSON.parse(word_dictionary.read.to_s)
    return word['found']
  end

  # The method returns true if the block never returns false or nil
  def letter_in_grid
    @answer = params[:word]
    @grid = params[:grid]
    @answer_letters = @answer.chars
    @answer_letters.each do |letter|
      @grid.include?(letter)
    end
  end

  def score
    @grid = params[:grid]
    @answer = params[:word]
    grid_letters = @grid.each_char do |letter|
      print "#{letter} "
    end
    if letter_in_grid && english_word
      @result = "Congratulation! #{@answer.upcase} is a valid English word."
    elsif letter_in_grid
      @result = "Sorry but #{@answer.upcase} does not seem to be an English word."
    else
      @result = "Sorry, but #{@answer.upcase} can’t be built out of #{grid_letters}."
    end
  end
end
