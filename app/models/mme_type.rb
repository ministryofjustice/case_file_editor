class MmeType
  VALUES = %w[
    cctv
    facewatch
    body_worn_video
    surveillance _camera
    telephone_call
  ]

  attribute :value, String
  validates :value, inclusion: { in: VALUES }
end
