# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Magentist.Repo.insert!(%Magentist.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Magentist.{Repo, User}

[
  %{
    email: "admin@magentist.io",
    password: "1234"
  },
  %{
    username: "mst@balance4u.dk",
    password: "idiot"
  },
]
|> Enum.map(&User.changeset(%User{}, &1))
|> Enum.each(&Repo.insert!(&1))
