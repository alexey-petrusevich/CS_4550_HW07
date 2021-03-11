# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     EventApp.Repo.insert!(%EventApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias EventApp.Repo
alias EventApp.Users.User
alias EventApp.Events.Event

alice = Repo.insert!(%User{name: "alice", email: "alice@alice"})
bob = Repo.insert!(%User{name: "bob", email: "bob@bob"})

Repo.insert!(%Event{user_id: alice.id, name: alice.name, description: "There will be Pizza"})
Repo.insert!(%Event{user_id: bob.id, name: bob.name, description: "There will be beer"})