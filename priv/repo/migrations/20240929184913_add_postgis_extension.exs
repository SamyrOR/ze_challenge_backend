defmodule ZeChallengeBackend.Repo.Migrations.AddPostgisExtension do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS postgis"
  end
end
