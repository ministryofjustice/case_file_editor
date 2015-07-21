class MmeType < Enumeration
  self.values = %w[
    cctv
    facewatch
    body_worn_video
    surveillance _camera
    telephone_call
  ]
end
