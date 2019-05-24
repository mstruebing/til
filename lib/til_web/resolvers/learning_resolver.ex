defmodule TilWeb.LearningResolver do
  alias Til.Learnings

  def all_learnings(_root, _args, _info) do
    learnings = Learnings.list_learnings
    {:ok, learnings}
  end

  def learnings_by_tag(_root, %{tag: tag}, _info) do
    learnings = Learnings.list_learnings(%{tag: tag})
    {:ok, learnings}
  end

  def learnings_by_user(_root, %{user_id: user_id}, _info) do
    {int_user_id, _} = Integer.parse(user_id)
    learnings = Learnings.list_learnings(%{user_id: int_user_id})
    {:ok, learnings}
  end
end
