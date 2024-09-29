defmodule ZeChallengeBackend.Core.Partner.Api do
  alias ZeChallengeBackend.Repo
  alias ZeChallengeBackend.Core.Partner
  import Ecto.Query
  import Geo.PostGIS

  def all do
    {:ok, Repo.all(Partner)}
  end

  def get(id) do
    Repo.get(Partner, id)
    |> case do
      nil -> {:error, :not_found}
      partner -> {:ok, partner}
    end
  end

  def get_nearest(coordinates) do
    query =
      from p in Partner,
        order_by: [st_distance(p.coverage_area, ^coordinates)],
        select: [:id, :coverage_area, :owner_name, :trading_name, :document, :address],
        limit: 1

    query
    |> Repo.one()
    |> case do
      nil -> {:error, :not_found}
      partner -> {:ok, partner}
    end
  end

  def delete(id) do
    case get(id) do
      {:ok, partner} -> Repo.delete(partner)
      error -> error
    end
  end

  def insert(params \\ %{}) do
    %Partner{}
    |> Partner.changeset(params)
    |> Repo.insert()
  end

  def update(model, params) do
    model |> Partner.changeset(params) |> Repo.update()
  end
end
