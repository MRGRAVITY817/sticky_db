defmodule StickyDb do
  @external_resource "README.md"

  @moduledoc "README.md"
             |> File.read!()
             |> String.split("<!-- MDOC -->")
             |> Enum.fetch!(1)

  @doc """
  Hello world.

  ## Examples

      iex> StickyDb.hello()
      :world

  """
  def hello do
    :world
  end
end
