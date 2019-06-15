defmodule TilWeb.LearningResolver do
  alias Til.Learnings

  def list_all(_root, _args, info) do
    learnings = Learnings.list_learnings()
    {:ok, filter_private_learnings(learnings, info)}
  end

  def learnings_by_tag(_root, %{tag: tag}, info) do
    learnings = Learnings.list_learnings(%{tag: tag})
    {:ok, filter_private_learnings(learnings, info)}
  end

  def learnings_by_user_id(_root, %{user_id: user_id}, info) do
    {int_user_id, _} = Integer.parse(user_id)
    learnings = Learnings.list_learnings(%{user_id: int_user_id})
    {:ok, filter_private_learnings(learnings, info)}
  end

  def learnings_by_user(_root, %{handle: handle}, info) do
    learnings = Learnings.list_learnings(%{handle: handle})
    {:ok, filter_private_learnings(learnings, info)}
  end

  def create(_root, args, %{context: %{current_user: current_user}}) do
    newArgs = %{
      user_id: current_user.id,
      content: args.content,
      tags: ["linux"],
      private: Map.get(args, :private, false)
    }

    Learnings.create_learning(newArgs)
  end

  def create(_root, _args, _info) do
    {:error, "Not Authorized"}
  end

  defp filter_private_learnings(learnings, info) do
    cond do
      Map.has_key?(info.context, :current_user) ->
        user_id = info.context.current_user.id

        # Remove all private learnings which are not from this user
        Enum.filter(learnings, fn learning -> !learning.private || learning.user_id == user_id end)

      true ->
        # Remove all private learnings
        Enum.filter(learnings, fn learning -> !learning.private end)
    end
  end
end
