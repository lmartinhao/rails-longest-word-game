require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(9)
  end

  def english_word
    word_dictionary = URI.open("https://wagon-dictionary.herokuapp.com/#{@answer}").read
    word = JSON.parse(word_dictionary)
    word['found']
  end

  def letter_in_grid
    @grid = params[:grid]
    @answer = params[:word]
    @look = @answer.chars.sort.all? { |letter| @grid.include?(letter) }
  end

  def score
    @grid = params[:grid]
    @answer = params[:word]
    grid_letters = @grid.each_char do |letter|
      print "#{letter} "
    end
    if letter_in_grid == true && english_word == true
      @result = "Congratulation! #{@answer.upcase} is a valid English word."
    elsif letter_in_grid == true
      @result = "Sorry, but #{@answer.upcase} does not seem to be an English word."
    else
      @result = "Sorry, but #{@answer.upcase} can’t be built out of #{grid_letters}."
    end
  end
end
