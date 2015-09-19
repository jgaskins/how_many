require 'clearwater/component'
require 'components/particle_list'
require 'components/container_list'
require 'components/guess_input'

# The Layout is our top-level application component.
Layout = Struct.new(:store) do
  include Clearwater::Component

  def render
    div([
      h1('How many'),
      h2('fit in'),
      selected_particle,
      selected_container,
      ParticleList.new(store.state[:particles], store.method(:dispatch)),
      ContainerList.new(store.state[:containers], store.method(:dispatch)),
      guess_input,
      message,
    ])
  end

  def selected_particle
    particle = store.state[:selected_particle]
    image_url = particle ? particle.image_url : '/assets/placeholder.png'
    label = particle ? particle.plural_name : '?'

    div([
      img(src: image_url, width: 142, height: 142),
      label,
    ])
  end

  def selected_container
    container = store.state[:selected_container]
    image_url = container ? container.image_url : '/assets/placeholder.png'
    label = container ? container.name : '?'

    div([
      img(src: image_url, width: 142, height: 142),
      label,
    ])
  end

  def message
    div(
      if store.state[:guessed_correct?].nil?
        'Waiting on guess'
      elsif store.state[:guessed_correct?]
        div([
          p('You are right!'),
          button({ onclick: method(:reset) }, "Play again!"),
        ])
      elsif store.state[:guessed_close?]
        'You are getting warm!'
      else
        'Not exactly.'
      end
    )
  end

  def reset
    store.dispatch Actions::Reset.new
  end

  def guess_input
    @guess_input ||= GuessInput.new(store)
  end
end
