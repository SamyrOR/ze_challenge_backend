defmodule(ZeChallengeBackend.PartnerContext) do
  alias ZeChallengeBackend.Core.Partner
  alias ZeChallengeBackend.Validate

  def all(_params) do
    case Partner.Api.all() do
      {:ok, partners} -> {:ok, partners}
    end
  end

  def get(params) do
    with {:ok, id} <- Validate.get_required(params, "id"),
         {:ok, _id} <- Validate.is_integer(id, "id"),
         {:ok, partner} <- Partner.Api.get(id) do
      {:ok, partner}
    else
      error -> error
    end
  end

  def create(params) do
    case Partner.Api.insert(params) do
      {:ok, partner} -> {:ok, partner}
      {:error, changeset} -> {:error, parse_errors(changeset)}
    end
  end

  def update(params) do
    with {:ok, id} <- Validate.get_required(params, "id"),
         {:ok, _id} <- Validate.is_integer(id, "id"),
         {:ok, partner} <- Partner.Api.get(id),
         {:ok, updated_partner} <-
           Partner.Api.update(partner, params) do
      {:ok, updated_partner}
    else
      error -> error
    end
  end

  def delete(params) do
    with {:ok, id} <- Validate.get_required(params, "id"),
         {:ok, _id} <- Validate.is_integer(id, "id"),
         {:ok, partner} <- Partner.Api.delete(id) do
      {:ok, partner}
    else
      error -> error
    end
  end

  defp parse_errors(changeset) do
    Enum.map(changeset.errors, fn {key, {msg, _}} -> "#{key}: #{msg}" end)
  end
end
