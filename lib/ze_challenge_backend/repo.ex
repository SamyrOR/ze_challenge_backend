defmodule ZeChallengeBackend.Repo do
  use Ecto.Repo,
    otp_app: :ze_challenge_backend,
    adapter: Ecto.Adapters.Postgres
end
