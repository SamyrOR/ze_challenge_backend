defmodule(ZeChallengeBackend.PartnerContext) do
  alias ZeChallengeBackend.Core.Partner
  alias ZeChallengeBackend.Validate

  def all(_params) do
    case Partner.Api.all() do
      {:ok, partners} -> {:ok, partners |> Enum.map(&json!(&1))}
    end
  end

  def get(params) do
    with {:ok, id} <- Validate.get_required(params, "id"),
         {:ok, _id} <- Validate.is_integer(id, "id"),
         {:ok, partner} <- Partner.Api.get(id) do
      {:ok, json!(partner)}
    else
      error -> error
    end
  end

  def create(params) do
    params_parsed = %{
      trading_name: params["tradingName"],
      owner_name: params["ownerName"],
      document: params["document"],
      coverage_area: params["coverageArea"],
      address: params["address"]
    }

    case Partner.Api.insert(params_parsed) do
      {:ok, partner} -> {:ok, json!(partner)}
      {:error, changeset} -> {:error, parse_errors(changeset)}
    end
  end

  def update(params) do
    # {id, _} = params["id"] |> Integer.parse()
    #
    # params_parsed = %{
    #   id: id,
    #   trading_name: params["tradingName"],
    #   owner_name: params["ownerName"],
    #   document: params["document"],
    #   coverage_area: params["coverageArea"],
    #   address: params["address"]
    # }
    #
    IO.inspect(params)

    #Do a way to update jsom to the partners
    with {:ok, id} <- Validate.get_required(params, "id"),
         {:ok, _id} <- Validate.is_integer(id, "id"),
         {:ok, partner} <- Partner.Api.get(id),
         {:ok, partner} <-
           {:ok,
            %{
              partner
              | coverage_area: params["coverageArea"],
                owner_name: params["ownerName"],
                trading_name: ["tradingName"]
            }},

    {:ok, updated_partner} <-
      Partner.Api.update partner, params do
        {:ok, json!(updated_partner)}
      else
        error -> error
      end
  end

  def delete(params) do
    with {:ok, id} <- Validate.get_required(params, "id"),
         {:ok, _id} <- Validate.is_integer(id, "id"),
         {:ok, partner} <- Partner.Api.delete(id) do
      {:ok, json!(partner)}
    else
      error -> error
    end
  end

  defp parse_errors(changeset) do
    Enum.map(changeset.errors, fn {key, {msg, _}} -> "#{key}: #{msg}" end)
  end

  defp json!(params) do
    Map.drop(params, [:__meta__, :__struct__])
  end
end
