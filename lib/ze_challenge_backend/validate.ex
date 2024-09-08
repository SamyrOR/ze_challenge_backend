defmodule ZeChallengeBackend.Validate do
  @moduledoc false

  def get_required(params, field) do
    case params[field] do
      nil -> {:error, "The field #{field} don't exists or is invalid"}
      value -> {:ok, value}
    end
  end

  def is_integer(value, field) do
    case Integer.parse(value) do
      {num, ""} -> {:ok, num}
      _ -> {:error, "the value of \"#{field}\" need been a integer"}
    end
  end
end
