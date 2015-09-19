require 'grand_central'

module Actions
  include GrandCentral

  SelectParticle = Action.with_attributes(:particle)
  AddParticle = Action.with_attributes(:particle)

  SelectContainer = Action.with_attributes(:container)
  AddContainer = Action.with_attributes(:container)

  SubmitGuess = Action.with_attributes(:guess)
end
