defmodule TilWeb.LearningResolver do
  alias Til.Accounts
  alias Til.Learnings

  def list_all(_root, _args, _info) do
    learnings = Learnings.list_learnings()
    {:ok, learnings}
  end

  def learnings_by_tag(_root, %{tag: tag}, _info) do
    learnings = Learnings.list_learnings(%{tag: tag})
    {:ok, learnings}
  end

  def learnings_by_user_id(_root, %{user_id: user_id}, _info) do
    {int_user_id, _} = Integer.parse(user_id)
    learnings = Learnings.list_learnings(%{user_id: int_user_id})
    {:ok, learnings}
  end

  def learnings_by_user(_root, %{handle: handle}, _info) do
    learnings = Learnings.list_learnings(%{handle: handle})
    {:ok, learnings}
  end

  def create(_root, args, %{context: %{current_user: current_user}}) do
    newArgs = %{user_id: current_user.id, content: args.content, tags: ["linux"]}
    Learnings.create_learning(newArgs)
  end

  def create(_root, _args, _info) do
    {:error, "Not Authorized"}
  end
end
