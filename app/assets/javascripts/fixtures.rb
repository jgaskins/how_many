module Fixtures
  module_function

  def particles
    [
      Particle.new(name: 'Monkey'),
      Particle.new(name: 'Hippopotamus'),
      Particle.new(name: 'Fox'),
      Particle.new(name: 'Lego'),
      Particle.new(name: 'Balloon'),
    ]
  end

  def containers
    [
      Container.new(name: 'Arcade Cabinet'),
      Container.new(name: 'Wolf Creek Crater'),
      Container.new(name: 'The White House'),
    ]
  end
end
