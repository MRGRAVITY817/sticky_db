defmodule StickyDB.Native do
  use Rustler,
    otp_app: :sticky_db,
    crate: "sticky"

  def glue_new(_storage), do: err()
  def glue_query(_glue_db, _sql), do: err()
  def memory_storage_new(), do: err()

  defp err, do: :erlang.nif_error(:nif_not_loaded)
end
