class GuessCalculation
  attr_reader :guess, :particle, :container

  def initialize(guess:, particle:, container:)
    @guess = guess
    @particle = particle
    @container = container
  end

  def correct?
    actual_count == guess
  end

  def close?
    (actual_count - guess).abs < (actual_count * 0.25)
  end

  def actual_count
    (container.volume / particle.volume).to_i
  end
end
