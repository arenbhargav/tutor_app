# frozen_string_literal: true

module ControllerHelpers
  def tutor_login(tutor)
    request.headers["Authorization"] = "Bearer #{JsonWebToken.encode(tutor_id: tutor.id)}"
  end
end