defmodule ZeChallengeBackendWeb.PartnerController do
  use ZeChallengeBackendWeb, :controller
  alias ZeChallengeBackend.PartnerContext

  def all(conn, params) when params == %{} do
    case PartnerContext.all(params) do
      {:ok, partners} -> json(conn, %{data: partners})
    end
  end

  def all(conn, %{"long" => long, "lat" => lat}) do
    {parsed_long, _} = Float.parse(long)
    {parsed_lat, _} = Float.parse(lat)

    case PartnerContext.get_nearest(%{
           "type" => "Point",
           "coordinates" => [parsed_long, parsed_lat]
         }) do
      {:ok, partner} -> json(conn, %{data: partner})
      {:error, msg} -> put_status(conn, 422) |> json(%{error: msg})
    end
  end

  def get(conn, params) do
    case PartnerContext.get(params) do
      {:ok, partner} -> json(conn, %{data: partner})
      {:error, msg} -> put_status(conn, 422) |> json(%{error: msg})
    end
  end

  def create(conn, params) do
    case PartnerContext.create(params) do
      {:ok, partner} -> json(conn, %{data: partner})
      {:error, msg} -> put_status(conn, 422) |> json(%{error: msg})
    end
  end

  def update(conn, params) do
    case PartnerContext.update(params) do
      {:ok, partner} -> json(conn, %{data: partner})
      {:error, msg} -> put_status(conn, 422) |> json(%{error: msg})
    end
  end

  def delete(conn, params) do
    case PartnerContext.delete(params) do
      {:ok, partner} -> json(conn, %{data: partner})
      {:error, msg} -> put_status(conn, 422) |> json(%{error: msg})
    end
  end
end
