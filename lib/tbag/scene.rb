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

module T_BAG
  class Scene
    def initialize(name, title)
      @name = name
      @title = title
      @actions = []
    end

    def pause
      @actions << {type: :pause}
    end

    def scene_change( scene )
      @actions << {type: :scene_change, scene: scene}
    end

    def text(dialog)
      @actions << {type: :text, dialog: dialog}
    end

    def prompt(question, type, error, &block)
      prompt = T_BAG::Prompt.new(question, type, error)
      @actions << {type: :prompt, prompt: prompt}
      Docile.dsl_eval(prompt, &block)
    end

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
          else
            $stderr.puts '[SCENE] Action not allowed'
        end
      end
    end
  end
end