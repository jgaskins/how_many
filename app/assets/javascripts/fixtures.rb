module Fixtures
  module_function

  def particles
    [
      Particle.new(
        name: 'Monkey',
        plural_name: 'Monkeys',
        height: 2,
        width: 1.5,
        depth: 1,
      ),
      Particle.new(
        name: 'Hippopotamus',
        plural_name: 'Hippopotami',
        height: 2,
        width: 2,
        depth: 1,
      ),
      Particle.new(
        name: 'Fox',
        plural_name: 'Foxes',
        height: 2,
        width: 2,
        depth: 1,
      ),
      Particle.new(
        name: 'Lego',
        plural_name: 'Legos',
        height: 2,
        width: 2,
        depth: 1,
      ),
      Particle.new(
        name: 'Balloon',
        plural_name: 'Balloons',
        height: 2,
        width: 2,
        depth: 1,
      ),
    ]
  end

  def containers
    [
      Container.new(
        name: 'Arcade Cabinet',
        height: 2,
        width: 2,
        depth: 1,
      ),
      Container.new(
        name: 'Wolf Creek Crater',
        height: 2,
        width: 2,
        depth: 1,
      ),
      Container.new(
        name: 'The White House',
        height: 2,
        width: 2,
        depth: 1,
      ),
    ]
  end
end
