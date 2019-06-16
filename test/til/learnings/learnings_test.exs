defmodule Til.LearningsTest do
  use Til.DataCase

  alias Til.Learnings

  describe "learnings" do
    alias Til.Learnings.Learning

    @valid_attrs %{
      content: "some content",
      created_at: "2010-04-17 14:00:00.000000Z",
      tags: [],
      updated_at: "2010-04-17 14:00:00.000000Z"
    }
    @update_attrs %{
      content: "some updated content",
      created_at: "2011-05-18 15:01:01.000000Z",
      tags: [],
      updated_at: "2011-05-18 15:01:01.000000Z"
    }
    @invalid_attrs %{content: nil, created_at: nil, tags: nil, updated_at: nil}

    def learning_fixture(attrs \\ %{}) do
      {:ok, learning} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Learnings.create_learning()

      learning
    end

    test "list_learnings/0 returns all learnings" do
      learning = learning_fixture()
      assert Learnings.list_learnings() == [learning]
    end

    test "get_learning!/1 returns the learning with given id" do
      learning = learning_fixture()
      assert Learnings.get_learning!(learning.id) == learning
    end

    test "create_learning/1 with valid data creates a learning" do
      assert {:ok, %Learning{} = learning} = Learnings.create_learning(@valid_attrs)
      assert learning.content == "some content"

      assert learning.created_at ==
               DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")

      assert learning.tags == []

      assert learning.updated_at ==
               DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
    end

    test "create_learning/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Learnings.create_learning(@invalid_attrs)
    end

    test "update_learning/2 with valid data updates the learning" do
      learning = learning_fixture()
      assert {:ok, learning} = Learnings.update_learning(learning, @update_attrs)
      assert %Learning{} = learning
      assert learning.content == "some updated content"

      assert learning.created_at ==
               DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")

      assert learning.tags == []

      assert learning.updated_at ==
               DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
    end

    test "update_learning/2 with invalid data returns error changeset" do
      learning = learning_fixture()
      assert {:error, %Ecto.Changeset{}} = Learnings.update_learning(learning, @invalid_attrs)
      assert learning == Learnings.get_learning!(learning.id)
    end

    test "delete_learning/1 deletes the learning" do
      learning = learning_fixture()
      assert {:ok, %Learning{}} = Learnings.delete_learning(learning)
      assert_raise Ecto.NoResultsError, fn -> Learnings.get_learning!(learning.id) end
    end

    test "change_learning/1 returns a learning changeset" do
      learning = learning_fixture()
      assert %Ecto.Changeset{} = Learnings.change_learning(learning)
    end
  end
end
