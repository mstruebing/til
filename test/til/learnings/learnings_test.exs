defmodule Til.LearningsTest do
  use Til.DataCase

  alias Til.Learnings

  describe "items" do
    alias Til.Learnings.Item

    @valid_attrs %{content: "some content"}
    @update_attrs %{content: "some updated content"}
    @invalid_attrs %{content: nil}

    def item_fixture(attrs \\ %{}) do
      {:ok, item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Learnings.create_item()

      item
    end

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Learnings.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Learnings.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      assert {:ok, %Item{} = item} = Learnings.create_item(@valid_attrs)
      assert item.content == "some content"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Learnings.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      assert {:ok, item} = Learnings.update_item(item, @update_attrs)
      assert %Item{} = item
      assert item.content == "some updated content"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Learnings.update_item(item, @invalid_attrs)
      assert item == Learnings.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Learnings.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Learnings.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Learnings.change_item(item)
    end
  end
end
