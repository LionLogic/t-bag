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
  # Defines a prompt and its run behavior.
  class Prompt
    # @param [String] question the prompt for the User
    # @param [ANY] type the type of the expected User input
    # @param [String] error the error to display if User input is invalid
    def initialize(question, type, error)
      @question = question
      @type = type
      @choices = {}
      @error = error
    end

    # Capture the User's answer to a prompt
    # @param [String] value the User input
    # @param [Block] block
    def choice(value, &block)
      if value.is_a? String
        value.downcase!
      end
      @choices[value] = Proc.new &block
    end

    # Define how to interpret prompt input.
    def run
      puts @question
      done = false
      until done
        answer = gets.strip

        if @type == Integer
          unless answer.to_i == 0
            answer = answer.to_i
          end
        elsif @type == String
          answer.downcase!
        end
        if answer.is_a? @type and (@choices[answer] or @choices[:any])
          if @choices[answer]
            @choices[answer].call(answer)
          else
            @choices[:any].call(answer)
          end
          done = true
        else
          puts @error
        end
      end
    end
  end
end