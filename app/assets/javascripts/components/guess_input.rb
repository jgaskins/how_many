require 'clearwater/component'
require 'stylesheet'

class GuessInput
  include Clearwater::Component
  Enter = 13
  Esc = 27

  attr_reader :guess_submission_handler, :store

  def initialize store
    @store = store
  end

  def render
    div([
      input(
        type: :number,
        value: guess,
        style: Stylesheet.guess_input,
        onkeyup: method(:handle_input),
        onchange: method(:handle_input_change),
      ),
      button(
        {
          style: Stylesheet.go_button,
          onclick: method(:handle_go),
          disabled: particle.nil? || container.nil? || guess.zero?
        },
        'go'
      ),
    ])
  end

  def guess
    store.state[:guess] || 0
  end

  def particle
    store.state[:selected_particle]
  end

  def container
    store.state[:selected_container]
  end

  def handle_input event
    key = event.code
    case key
    when Enter
      handle_go event
    when Esc
      event.target.clear
      handle_input_change event
    else
      handle_input_change event
      call
    end
  end

  def handle_input_change event
    Kernel.p guess = event.target.value.to_i
    store.dispatch Actions::UpdateGuess.new(guess)
  end

  def handle_go event
    event.prevent
    store.dispatch Actions::SubmitGuess.new(guess)
  end
end
