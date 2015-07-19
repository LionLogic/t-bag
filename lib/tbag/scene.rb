module T_BAG
  class Scene
    def initialize(name,title)
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
            puts
          else
            $stderr.puts '[SCENE] Action not allowed'
        end
      end
    end

  end
end