require 'opal'
require 'clearwater'
require 'grand_central'

require 'models/particle'
require 'models/container'
require 'actions'
require 'fixtures'

initial_state = {
  particles: Fixtures.particles,
  containers: Fixtures.containers,
  selected_particle: nil,
  selected_container: nil,
}
store = GrandCentral::Store.new(initial_state) do |state, action|
  case action
  when Actions::SelectParticle
    state.merge selected_particle: action.particle
  when Actions::AddParticle
    state.merge particles: state[:particles] + [action.particle]
  when Actions::SelectContainer
    state.merge selected_container: action.container
  when Actions::AddContainer
    state.merge containers: state[:containers] + [action.container]
  else
    state
  end
end

Layout = Struct.new(:store) do
  include Clearwater::Component

  def render
    div([
      h1('How many'),
      h2('fit in a'),
      div(selected_particle),
      div(selected_container),
      particle_list,
      container_list,
      div(guess),
      div(message),
    ])
  end

  def selected_particle
    particle = store.state[:selected_particle]
    if particle
      particle.name
    end
  end

  def selected_container
    container = store.state[:selected_container]
    if container
      container.name
    end
  end

  def particle_list
    ul({ style: list_style },
      store.state[:particles].map { |particle|
        li(
          {
            onclick: proc {
              store.dispatch Actions::SelectParticle.new(particle)
            }
          },
          particle.name
        )
      }
    )
  end

  def container_list
    ul({ style: list_style },
      store.state[:containers].map { |container|
        li(
          {
            onclick: proc {
              store.dispatch Actions::SelectContainer.new(container)
            }
          },
          container.name
        )
      }
    )
  end

  def list_style
    {
      display: 'inline-block',
      vertical_align: 'top',
      width: '25%',
    }
  end

  def guess
  end

  def message
  end
end

app = Clearwater::Application.new(
  component: Layout.new(store),
  element: $document['#app'],
)

store.on_dispatch do |old_state, new_state|
  app.render
end

app.call
