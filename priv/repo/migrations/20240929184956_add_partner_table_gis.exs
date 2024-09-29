defmodule ZeChallengeBackend.Repo.Migrations.AddPartnerTableGis do
  use Ecto.Migration

  def change do
    create table("partners") do
      add :trading_name, :string
      add :owner_name, :string
      add :document, :string
      add :coverage_area, :geometry
      add :address, :geometry

      timestamps()
    end
  end
end
