class CaseMarker
  VALUES = %w[
    AE
    CO
    DH
    DV
    FM
    FT
    HC
    HP
    HT
    LO
    NU
    PW
    RA
    RE
    RP
    TG
  ]

  attribute :value, String
  validates :value, inclusion: { in: VALUES }
end
