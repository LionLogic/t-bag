# T-BAG: Text-Based Adventure Game Framework

##Project Description
A domain-specific language for text-based adventure games.

- - - -
##Project Goals

* DSL including scenes, prompts, texts, choices, scene changes, and pauses.
* Add special scene 'game over.'

Fork:

* Add ASCII world map.
* Add map navigation.
 
Fork:

* Add audio playing functionality.
* Add GUI
* Add image displaying functionality.

##Example
``` ruby
require T_BAG

game 'Zork', 'Infocom' do
  menu :menuscene
  start :scene1
  scene :scene1, 'West of House' do
    text 'You are standing in an open field west of a white house, with a boarded front door.'
    pause
    text 'There is a small mailbox here.'
    pause
    prompt 'What would you like to do?', String, 'I don\'t know that word.' do
      choice 'open' do
        puts 'The door cannot be opened.'
      end
      choice 'open mailbox' do
        puts 'Opening the small mailbox reveals a leaflet.'
      end
    end
    prompt 'What would you like to do?', String, 'I don\'t know that word.' do
      choice 'read leaflet' do
        scene_change :scene2
      end
    end
  end
  scene :scene2, 'WELCOME TO ZORK!' do
    text 'WELCOME TO ZORK!'
    pause
    text 'ZORK is a game of adventure, danger, and low cunning.'
    text 'In it you will explore some of the most amazing territory ever seen by mortals.'
    text 'No computer should be without one!'
    pause
    scene_change :endgame
  end
  game_over do
    text 'You were eaten by a grue.'
    pause
    prompt 'Would you like to start over?', String, 'I\'m afraid I don\'t like that answer...' do
      choice 'yes' do
        $game.reset
      end
      choice 'no' do
        $game.quit
      end
    end
  end
end

run
```

- - - -
The original Zork source code is copyright © 1978 Massachusetts Institute of Technology. All rights reserved.

##Release Notes
Coming soon!

##Contact
Benjamin S. Meyers < <lion.logic.org@gmail.com> >

Bryan T. Meyers < <bmeyers@datadrake.com> >

##Licensing
The MIT License (MIT)

Copyright (c) 2015 Benjamin Meyers as Lion Logic

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
