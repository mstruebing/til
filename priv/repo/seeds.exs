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
alias Til.Accounts.User
alias Til.Repo


user = %User{email: "max@max.de", password_hash: "1234"} |> Repo.insert!
user = %User{email: "alex@alex.de", password_hash: "1234"} |> Repo.insert!

%Item{content: "VIM", tags: ["linux", "programming"], user_id: 1} |> Repo.insert!
%Item{content: "TMUX", tags: ["linux", "shell"], user_id: 1} |> Repo.insert!
