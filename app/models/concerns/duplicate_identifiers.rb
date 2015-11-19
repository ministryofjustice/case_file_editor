module DuplicateIdentifiers
  def duplicate_identifiers(ids)
    ids.each_with_object({}) { |e, a| a[e] = a.fetch(e, 0) + 1 }.
      select { |_, n| n > 1 }.
      map(&:first)
  end
end
