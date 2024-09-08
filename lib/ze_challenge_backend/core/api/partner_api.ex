defmodule ZeChallengeBackend.Core.Partner.Api do
  alias ZeChallengeBackend.Repo
  alias ZeChallengeBackend.Core.Partner

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

