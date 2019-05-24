defmodule TilWeb.LearningResolver do
  alias Til.Learnings

  def all_learnings(_root, _args, _info) do
    learnings = Learnings.list_learnings
    {:ok, learnings}
  end

  def user_learnings(_root, args, _info) do
    # Refactor to do in the Repothingy
    learnings = Enum.filter(Learnings.list_learnings, fn learning -> Integer.to_string(learning.user_id) == args.user_id end)
    {:ok, learnings}
  end
end
