require 'opal'
require 'clearwater'
require 'grand_central'
require 'pp'

require 'models/particle'
require 'models/container'
require 'actions'
require 'fixtures'
require 'stylesheet'

require 'components/layout'
require 'guess_calculation'

initial_state = {
  # Using fixtures for particles and containers to start with
  particles: Fixtures.particles,
  containers: Fixtures.containers,

  # When the app loads, nothing is selected, so we just make them nil
  selected_particle: nil,
  selected_container: nil,

  guess: nil,
  guessed_correct?: nil,
  guessed_close?: nil,
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

  when Actions::UpdateGuess
    state.merge guess: action.guess
  when Actions::SubmitGuess
    calculation = GuessCalculation.new(
      guess: action.guess.to_i,
      particle: state[:selected_particle],
      container: state[:selected_container],
    )

    state.merge(
      guessed_correct?: calculation.correct?,
      guessed_close?: calculation.close?
    )

  when Actions::Reset
    state.merge(
      guess: nil,
      selected_particle: nil,
      selected_container: nil,
      guessed_correct?: nil,
      guessed_close?: nil,
    )

  # We must always return a state object, so if we didn't handle the
  # action, we just return the current state.
  else
    state
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
