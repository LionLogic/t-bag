# T-BAG: Text-Based Adventure Game Framework

##Project Description
A domain-specific language for text-based adventure games.

##Example
``` ruby
game 'Zork', 'Infocom' do
    start :scene1
    scene :scene1, 'West of House' do
        text 'You are standing in an open field west of a white house, with a boarded front door.'
        text 'There is a small mailbox here.'
        prompt '', String, 'I don't know that word.' do
            choice 'open' do
                puts 'The door cannot be opened.'
            end
            choice 'open mailbox' do
                puts 'Opening the small mailbox reveals a leaflet.'
            end
        end
        prompt '', String, 'I don't know that word.' do
            choice 'read leaflet' do
                scene_change :scene2
            end
        end
    end
    scene :scene2, 'WELCOME TO ZORK!' do
        text 'WELCOME TO ZORK!'
        text 'ZORK is a game of adventure, danger, and low cunning.'
        text 'In it you will explore some of the most amazing territory ever seen by mortals.'
        text 'No computer should be without one!'
        pause
        scene_change :endgame
    end
    game_over do
        text 'You were eaten by a grue.'
        pause
    end
end
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
