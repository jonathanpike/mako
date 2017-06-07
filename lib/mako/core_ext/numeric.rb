class Numeric
  SECONDS_IN_DAY = 86_400

  def days
    self * SECONDS_IN_DAY
  end
  alias day days
end
