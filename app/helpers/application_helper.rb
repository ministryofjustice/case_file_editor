module ApplicationHelper
  def ordinalize(n)
    return nil unless n
    "#{n}#{n.ordinal}"
  end
end
