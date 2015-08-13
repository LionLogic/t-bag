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
require_relative 'lib/tbag'

Gem::Specification.new do |s|
  s.name        = 't-bag'
  s.version     = T_BAG::VERSION
  s.date        = '2015-08-13'
  s.summary     = 'Text-Based Adventure Game Framework'
  s.description = 'A framework for implementing domain-specific languages for text-based adventure games.'
  s.authors     = ['Benjamin S. Meyers', 'Bryan T. Meyers']
  s.email       = %w(lion.logic.org@gmail.com bmeyers@datadrake.com)
  s.files       = Dir.glob('lib/**/*')
  s.homepage    = 'https://github.com/meyersbs/t-bag'
  s.license     = 'MIT'
end
