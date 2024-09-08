defmodule ZeChallengeBackend.Core.Partner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "partner" do
    field :tranding_name, :string
    field :owner_name, :string
    field :document, :string
    field :coverage_area, :map
    field :address, :map

    timestamps()
  end

  def changeset(partner, attrs) do
    partner
    |> cast(attrs, [:tranding_name, :owner_name, :document, :coverage_area, :address])
    |> validate_required([:tranding_name, :owner_name, :document, :coverage_area, :address])
  end
end
