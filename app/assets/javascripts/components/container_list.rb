require 'clearwater/component'
require 'stylesheet'
require 'actions'

ContainerList = Struct.new(:containers, :dispatcher) do
  include Clearwater::Component

  def render
    ul({ style: Stylesheet.selection_list },
      containers.map { |container|
        li({ onclick: proc { handle_click(container) } }, container.name)
      }
    )
  end

  def handle_click container
    dispatcher.call Actions::SelectContainer.new(container)
  end
end
