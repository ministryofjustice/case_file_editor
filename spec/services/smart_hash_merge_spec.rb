RSpec.describe SmartHashMerge do
  subject { described_class }

  it "creates nodes that do not exist in LHS" do
    lhs = {}
    rhs = { "foo" => { "bar" => "baz" } }
    expect(subject.merge(lhs, rhs)).to eq(rhs)
  end

  it "merges hashes" do
    lhs = { "foo" => { "a" => 1 } }
    rhs = { "foo" => { "b" => 2 } }
    expected = { "foo" => { "a" => 1, "b" => 2 } }
    expect(subject.merge(lhs, rhs)).to eq(expected)
  end

  it "replaces non-collection hash values from LHS with values from RHS" do
    lhs = { "foo" => { "a" => 1 } }
    rhs = { "foo" => { "a" => 2 } }
    expected = { "foo" => { "a" => 2 } }
    expect(subject.merge(lhs, rhs)).to eq(expected)
  end

  it "merges array values" do
    lhs = { "foo" => ["bar"] }
    rhs = { "foo" => ["baz"] }
    expected = { "foo" => ["bar", "baz"] }
    expect(subject.merge(lhs, rhs)).to eq(expected)
  end

  it "merges LHS value with RHS array" do
    lhs = { "foo" => "bar" }
    rhs = { "foo" => ["baz"] }
    expected = { "foo" => ["bar", "baz"] }
    expect(subject.merge(lhs, rhs)).to eq(expected)
  end

  it "does not merge nil array values" do
    lhs = { }
    rhs = { "foo" => ["baz"] }
    expected = { "foo" => ["baz"] }
    expect(subject.merge(lhs, rhs)).to eq(expected)
  end

  it "does not change hash" do
    lhs = { "foo" => {} }
    rhs = { "foo" => { "bar" => ["baz"] } }
    expected = { "foo" => {} }
    subject.merge(lhs, rhs)
    expect(lhs).to eq(expected)
  end
end
