class RemandApplicationMapper < Yaks::Mapper
  has_many :substantial_grounds
  has_many :bail_conditions
end
