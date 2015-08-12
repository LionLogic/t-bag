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

module T_BAG
  # Defines a scene and its run behavior.
  class Scene
    # @param [String] name the name of the scene
    # @param [String] title the title of the scene
    def initialize(name, title)
      @name = name
      @title = title
      @actions = []
    end

    # Add a pause to the action queue.
    def pause
      @actions << {type: :pause}
    end

    # Add a scene change to the action queue.
    # @param [Symbol] scene a scene
    def scene_change( scene )
      @actions << {type: :scene_change, scene: scene}
    end

    # Add a set of text to the action queue.
    # @param [String] dialog the text to be output to the User
    def text(dialog)
      @actions << {type: :text, dialog: dialog}
    end

    # Add a prompt to the action queue.
    # @param [String] question the prompt for the User
    # @param [ANY] type the type of the expected User input
    # @param [String] error the error to display if User input is invalid
    # @param [Block] block
    def prompt(question, type, error, &block)
      prompt = T_BAG::Prompt.new(question, type, error)
      @actions << {type: :prompt, prompt: prompt}
      Docile.dsl_eval(prompt, &block)
    end

    # Add a save to the action queue.
    # @param [String] outfile the name of the file to save to
    def save_game(outfile)
      @actions << {type: :save, filename: outfile}
    end

    # Add a load to the action queue.
    # @param [String] infile the name of the file to load from
    def load_game(infile)
      @actions << {type: :load, filename: infile}
    end

    # Create a scene change for the game over scene.
    def game_over
      scene_change :endgame
    end

    # Create a scene change for the main menu scene.
    def main_menu
      scene_change :menu
    end

    # Define how a scene runs.
    def run
      @actions.each do |a|
        case a[:type]
          when :pause
            print 'Continue...'
            gets
            puts
          when :scene_change
            $game.next_scene a[:scene]
          when :text
            a[:dialog].bytes.each do |c|
              putc c
              sleep(0.05)
            end
            putc "\n"
          when :prompt
            a[:prompt].run
          when :save
            $game.save_game a[:filename]
          when :load
            $game.load_game a[:filename]
          else
            $stderr.puts '[SCENE] Action not allowed'
        end
      end
    end
  end
end