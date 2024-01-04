defmodule StickyDbTest do
  use ExUnit.Case
  doctest StickyDb

  test "greets the world" do
    assert StickyDb.hello() == :world
  end
end
