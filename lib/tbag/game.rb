require_relative '../tbag'

require 'docile'

module T_BAG
  class Game
    def initialize(title,author)
      @title = title
      @author = author
      @scenes = {}
      @current_scene = nil
      @next_scene = nil
    end

    def scene( name , title , &block)
      scene = T_BAG::Scene.new(name,title)
      @scenes[name] = scene
      Docile.dsl_eval(scene, &block)
    end

    def start(scene)
      @current_scene = scene
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
  end
end