defmodule StickyDB.Storages.MemoryStorage do
  @moduledoc """
  Methods for creating and using memory storage.
  """

  @doc """
  Create in-memory storage instance.
  """
  def new() do
    StickyDB.Native.memory_storage_new()
  end
end
