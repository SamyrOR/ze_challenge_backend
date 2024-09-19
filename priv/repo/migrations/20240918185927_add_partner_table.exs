defmodule ZeChallengeBackend.Repo.Migrations.AddPartnerTable do
  use Ecto.Migration

  def change do
    create table("partner") do
      add :trading_name, :string
      add :owner_name, :string
      add :document, :string
      add :coverage_area, :map
      add :address, :map

      timestamps()
    end
  end
end
