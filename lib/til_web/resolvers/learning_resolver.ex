defmodule TilWeb.LearningResolver do
  @moduledoc """
  This module defines the resolvers for learnings.
  """

  alias Til.Accounts
  alias Til.Learnings

  def list_all(_root, _args, info) do
    learnings =
      Learnings.list_learnings()
      |> filter_private_learnings(info)
      |> fill_learnings_with_author

    {:ok, learnings}
  end

  def learnings_by_tag(_root, %{tag: tag}, info) do
    learnings =
      Learnings.list_learnings(%{tag: tag})
      |> filter_private_learnings(info)
      |> fill_learnings_with_author

    {:ok, learnings}
  end

  def learnings_by_user_id(_root, %{user_id: user_id}, info) do
    {int_user_id, _} = Integer.parse(user_id)

    learnings =
      Learnings.list_learnings(%{user_id: int_user_id})
      |> filter_private_learnings(info)
      |> fill_learnings_with_author

    {:ok, learnings}
  end

  def learnings_by_user(_root, %{handle: handle}, info) do
    learnings =
      Learnings.list_learnings(%{handle: handle})
      |> filter_private_learnings(info)
      |> fill_learnings_with_author

    {:ok, learnings}
  end

  def learning_count(_root, _args, _info) do
    count = Learnings.count_learnings()
    {:ok, count}
  end

  def create(_root, args, %{context: %{current_user: current_user}}) do
    learning_args = %{
      user_id: current_user.id,
      title: args.title,
      content: args.content,
      tags: args.tags,
      private: Map.get(args, :private, false)
    }

    Learnings.create_learning(learning_args)
  end

  def create(_root, _args, _info) do
    {:error, "Not Authorized"}
  end

  defp fill_learnings_with_author(learnings) do
    learnings
    |> Enum.map(&fill_learning_with_author/1)
  end

  defp fill_learning_with_author(learning) do
    Map.merge(learning, %{author: Accounts.get_user!(learning.user_id).handle})
  end

  defp filter_private_learnings(learnings, info) do
    if Map.has_key?(info.context, :current_user) do
      user_id = info.context.current_user.id
      # Remove all private learnings which are not from this user
      Enum.filter(learnings, fn learning -> !learning.private || learning.user_id == user_id end)
    else
      # Remove all private learnings
      Enum.filter(learnings, fn learning -> !learning.private end)
    end
  end
end
