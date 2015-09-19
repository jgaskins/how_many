require 'opal'
require 'clearwater'
require 'grand_central'

require 'models/particle'
require 'models/container'
require 'actions'
require 'fixtures'
require 'stylesheet'

initial_state = {
  # Using fixtures for particles and containers to start with
  particles: Fixtures.particles,
  containers: Fixtures.containers,

  # When the app loads, nothing is selected, so we just make them nil
  selected_particle: nil,
  selected_container: nil,
}
store = GrandCentral::Store.new(initial_state) do |state, action|
  # When an action is dispatched, we return the new app state based on
  # the current app state and the action being dispatched. The action can
  # have metadata associated with it, like which particle or container
  # we are acting on.

  case action

  # If the user selects a different particle or container, just set that.
  when Actions::SelectParticle
    state.merge selected_particle: action.particle
  when Actions::SelectContainer
    state.merge selected_container: action.container

  # Adding a particle or container just appends it to the list of existing
  # ones.
  when Actions::AddParticle
    state.merge particles: state[:particles] + [action.particle]
  when Actions::AddContainer
    state.merge containers: state[:containers] + [action.container]

  # We must always return a state object, so if we didn't handle the
  # action, we just return the current state.
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
      ParticleList.new(store.state[:particles], store.method(:dispatch)),
      ContainerList.new(store.state[:containers], store.method(:dispatch)),
      div(guess),
      div(message),
    ])
  end

  def selected_particle
    SelectedValue.new(store.state[:selected_particle])
  end

  def selected_container
    SelectedValue.new(store.state[:selected_container])
  end

  def guess
  end

  def message
  end
end

ParticleList = Struct.new(:particles, :dispatcher) do
  include Clearwater::Component

  def render
    ul(
      { style: Stylesheet.selection_list },
      particles.map { |particle|
        li({ onclick: proc { handle_click(particle) } }, particle.name)
      }
    )
  end

  def handle_click particle
    dispatcher.call Actions::SelectParticle.new(particle)
  end
end

ContainerList = Struct.new(:containers, :dispatcher) do
  include Clearwater::Component

  def render
    ul(
      { style: Stylesheet.selection_list },
      containers.map { |container|
        li({ onclick: proc { handle_click(container) } }, container.name)
      }
    )
  end

  def handle_click container
    dispatcher.call Actions::SelectContainer.new(container)
  end
end

SelectedValue = Struct.new(:value) do
  include Clearwater::Component

  def render
    if value
      div(value.name)
    end
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
