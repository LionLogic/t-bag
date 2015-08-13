require_relative '../lib/tbag'
include T_BAG

game 'Zork', 'Infocom' do
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