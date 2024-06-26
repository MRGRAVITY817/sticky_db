defmodule MemoryStorageTest do
  use ExUnit.Case
  doctest StickyDB

  alias StickyDB.Storages.MemoryStorage
  alias StickyDB

  test "basic querying after creating memory storage" do
    # Arrange

    db = StickyDB.glue_new(MemoryStorage.new())

    assert StickyDB.query(db, """
           CREATE TABLE Foo (id INTEGER);
           CREATE TABLE Bar;
           """) == {
             :ok,
             [
               %{"type" => "CREATE TABLE"},
               %{"type" => "CREATE TABLE"}
             ]
           }

    assert StickyDB.query(db, """
           INSERT INTO Foo VALUES (1), (2), (3)
           """) == {
             :ok,
             [%{"affected" => 3, "type" => "INSERT"}]
           }

    assert StickyDB.query(db, """
           INSERT INTO Bar VALUES
           ('{ "hello": 1 }'),
           ('{ "world": "cookie" }');
           """) == {
             :ok,
             [%{"affected" => 2, "type" => "INSERT"}]
           }

    assert StickyDB.query(
             db,
             """
             SELECT * FROM Bar
             """
           ) ==
             {
               :ok,
               [
                 %{
                   "rows" => [
                     %{"hello" => 1},
                     %{"world" => "cookie"}
                   ],
                   "type" => "SELECT"
                 }
               ]
             }

    assert StickyDB.query(
             db,
             """
             SELECT * FROM Foo
             """
           ) ==
             {:ok,
              [
                %{
                  "rows" => [
                    %{"id" => 1},
                    %{"id" => 2},
                    %{"id" => 3}
                  ],
                  "type" => "SELECT"
                }
              ]}

    assert StickyDB.query(
             db,
             """
             UPDATE Foo SET id = id + 2 WHERE id = 3
             """
           ) ==
             {
               :ok,
               [
                 %{
                   "type" => "UPDATE",
                   "affected" => 1
                 }
               ]
             }

    assert StickyDB.query(
             db,
             """
             DELETE FROM Foo WHERE id < 5
             """
           ) ==
             {:ok,
              [
                %{
                  "type" => "DELETE",
                  "affected" => 2
                }
              ]}

    assert StickyDB.query(
             db,
             """
             SELECT * FROM Foo
             """
           ) ==
             {:ok,
              [
                %{
                  "type" => "SELECT",
                  "rows" => [%{"id" => 5}]
                }
              ]}

    assert StickyDB.query(
             db,
             """
             SHOW COLUMNS FROM Foo
             """
           ) ==
             {
               :ok,
               [
                 %{
                   "type" => "SHOW COLUMNS",
                   "columns" => [
                     %{
                       "name" => "id",
                       "type" => "INT"
                     }
                   ]
                 }
               ]
             }

    assert StickyDB.query(
             db,
             """
             SHOW TABLES
             """
           ) ==
             {:ok,
              [
                %{
                  "type" => "SHOW TABLES",
                  "tables" => ["Bar", "Foo"]
                }
              ]}

    assert StickyDB.query(
             db,
             """
             DROP TABLE IF EXISTS Foo
             """
           ) ==
             {:ok,
              [
                %{"type" => "DROP TABLE"}
              ]}
  end
end
