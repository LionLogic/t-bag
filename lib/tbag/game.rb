# The MIT License (MIT)

# Copyright (c) 2015 Benjamin Meyers as Lion Logic

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require_relative '../tbag'

require 'docile'

module T_BAG
  class Game
    def initialize(title, author)
      @title = title
      @author = author
      @scenes = {}
      @current_scene = nil
      @start_scene = nil
      @next_scene = nil
    end

    def scene(name, title, &block)
      scene = T_BAG::Scene.new(name, title)
      @scenes[name] = scene
      Docile.dsl_eval(scene, &block)
    end

    def game_over(&block)
      game_over = T_BAG::Game_Over.new
      @scenes[:endgame] = game_over
      Docile.dsl_eval(game_over, &block)
    end

    def start(scene)
      @current_scene = scene
      @start_scene = scene
    end

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

    def next_scene(scene)
      @next_scene = scene
    end

    def reset
      @next_scene = @start_scene
    end

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
        end
      rescue
        puts 'Load Failed!'
      end
    end
  end
end