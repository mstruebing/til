# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Til.Repo.insert!(%Til.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Til.Learnings.Item
alias Til.Repo

%Item{content: "VIM", tags: ["linux", "programming"]} |> Repo.insert!
%Item{content: "TMUX", tags: ["linux", "shell"]} |> Repo.insert!
