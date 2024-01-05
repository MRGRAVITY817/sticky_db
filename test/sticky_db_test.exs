defmodule StickyDBTest do
  use ExUnit.Case
  doctest StickyDB

  test "greets the world" do
    assert StickyDB.hello() == :world
  end
end
