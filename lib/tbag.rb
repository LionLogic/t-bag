=begin
The MIT License (MIT)

Copyright (c) 2015 Benjamin Meyers as Lion Logic <lion.logic.org@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
=end

require_relative 'tbag/game'
require_relative 'tbag/prompt'
require_relative 'tbag/scene'
require_relative 'tbag/game_over'
require_relative 'tbag/main_menu'

require 'docile'

# A framework for writing text-based adventure games.
# @author Benjamin S. Meyers
module T_BAG
  # The version number.
  VERSION = '0.0.4'

  # @param [String] title the game title
  # @param [String] author the game author
  # @param [Block] block
  def game(title, author, &block)
    $game = T_BAG::Game.new(title, author)

    Docile.dsl_eval($game, &block)
  end

  # Run the game.
  # @return [Void]
  def run
    $game.run
  end
end
