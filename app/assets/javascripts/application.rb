require 'opal'
require 'clearwater'

class Layout
  include Clearwater::Component

  def render
    div([
    ])
  end
end

app = Clearwater::Application.new(
  component: Layout.new,
  element: $document['#app'],
)
