class SmartHashMerge
  def self.merge(lhash, rhash)
    new(lhash, rhash).merge
  end

  def initialize(lhash, rhash)
    @lhash = lhash
    @rhash = rhash
  end

  def merge
    lhash = @lhash.dup
    deep_merge(lhash, @rhash)
  end

private

  def deep_merge(lhash, rhash)
    merged = lhash.dup
    rhash.each do |key, rvalue|
      merged[key] = merge_pair(lhash[key], rvalue)
    end
    merged
  end

  # rubocop:disable Metrics/PerceivedComplexity
  # rubocop:disable Metrics/CyclomaticComplexity
  def merge_pair(lvalue, rvalue)
    if lvalue.is_a?(Hash) && rvalue.is_a?(Hash)
      deep_merge(lvalue, rvalue)
    elsif lvalue.is_a?(Array) && rvalue.is_a?(Array)
      lvalue + rvalue
    elsif rvalue.is_a?(Array) && !lvalue.nil?
      [lvalue] + rvalue
    else
      rvalue
    end
  end
end
