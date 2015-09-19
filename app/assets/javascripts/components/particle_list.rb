require 'clearwater/component'
require 'stylesheet'
require 'actions'

ParticleList = Struct.new(:particles, :dispatcher) do
  include Clearwater::Component

  def render
    ul({ style: Stylesheet.selection_list },
      particles.map { |particle|
        li({ onclick: proc { handle_click(particle) } }, particle.name)
      }
    )
  end

  def handle_click particle
    dispatcher.call Actions::SelectParticle.new(particle)
  end
end
