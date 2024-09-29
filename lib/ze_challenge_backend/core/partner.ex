defmodule ZeChallengeBackend.Core.Partner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "partners" do
    field :trading_name, :string
    field :owner_name, :string
    field :document, :string
    field :coverage_area, Geo.PostGIS.Geometry
    field :address, Geo.PostGIS.Geometry

    timestamps()
  end

  def changeset(partner, attrs) do
    partner
    |> cast(attrs, [:trading_name, :owner_name, :document, :coverage_area, :address])
    |> validate_required([:trading_name, :owner_name, :document, :coverage_area, :address])
  end
end
