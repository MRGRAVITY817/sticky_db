defmodule StickyDB.MemoryStorage.Adapter do
  @behaviour Ecto.Adapter

  @impl Ecto.Adapter
  defmacro __before_compile__(_opts), do: :ok
end
