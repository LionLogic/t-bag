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

require_relative '../tbag'

require 'docile'

module T_BAG
  # Defines a game and its run behavior.
  class Game
    # @param [String] title the game title
    # @param [String] author the game author
    def initialize(title, author)
      @title = title
      @author = author
      @scenes = {}
      @current_scene = nil
      @start_scene = nil
      @next_scene = nil
      @menu_scene = nil
      @called = false
    end

    # Add a scene to the scene queue.
    # @param [String] name the name of the scene
    # @param [String] title the title of the scene
    # @param [Block] block
    # @return [Void]
    def scene(name, title, &block)
      scene = T_BAG::Scene.new(name, title)
      @scenes[name] = scene
      Docile.dsl_eval(scene, &block)
    end

    # Add a game over scene to the scene queue.
    # @param [Block] block
    # @return [Void]
    def game_over(&block)
      game_over = T_BAG::Game_Over.new
      @scenes[:endgame] = game_over
      Docile.dsl_eval(game_over, &block)
    end

    # Add a main menu scene to the scene queue.
    # @param [Block] block
    # @return [Void]
    def main_menu(&block)
      main_menu = T_BAG::Main_Menu.new
      @scenes[:menu] = main_menu
      Docile.dsl_eval(main_menu, &block)
    end

    # Save the given scene as the starting scene and start the scene.
    # @param [Symbol] scene a scene
    # @return [Void]
    def start(scene)
      if @called == false
        @current_scene = scene
        @start_scene = scene
        @called = true
      else
        @start_scene = scene
      end
    end

    # Save the given scene as the menu scene.
    # @param [Symbol] scene a scene
    # @return [Void]
    def menu(scene)
      @menu_scene = scene
    end

    # Run the scenes in chronological order until it finds a nil scene.
    # @return [Void]
    def run
      until @current_scene.nil?
        scene = @scenes[@current_scene]
        if scene.nil?
          $stderr.puts "[GAME] Scene '#{@current_scene}' does not exist"
        end
        scene.run
        @current_scene = @next_scene
      end
    end

    # Set the given scene to the next scene in the game.
    # @param [Symbol] scene a scene
    # @return [Void]
    def next_scene(scene)
      @next_scene = scene
    end

    # Reset the game by going back to the starting scene.
    # @return [Void]
    def reset
      @next_scene = @start_scene
    end

    # Reset the game by going back to the menu scene.
    # @return [Void]
    def tomenu
      @next_scene = @menu_scene
    end

    # Quit the game.
    # @return [Void]
    def quit
      puts 'Goodbye!'
      exit
    end

    # Save the current game state as outfile.
    # @param [String] outfile the name of the file to save to
    # @return [Void]
    def save_game(outfile)
      begin
      if File.exist? outfile
        out_file = File.open(outfile, 'r+')
        out_file.puts @current_scene
        out_file.close
        puts 'Save Successful!'
      else
        out_file = File.new(outfile, 'w')
        puts 'Created New Save File...'
        out_file.puts @current_scene
        out_file.close
        puts 'Save Successful!'
      end
      rescue Exception => ex
        puts 'Save Failed!'
      end
    end

    # Load a game state from infile.
    # @param [String] infile the name of the file to load from
    # @return [Void]
    def load_game(infile)
      begin
        if File.exist? infile
          in_file = File.open(infile, 'r+')
          state = in_file.gets.chomp.intern
          #print state
          next_scene state
          puts 'Load Successful!'
        else
          puts 'File ' + String(infile) + ' not found.'
          reset
        end
      rescue
        puts 'Load Failed!'
      end
    end
  end
end