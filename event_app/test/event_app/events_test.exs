defmodule EventApp.EventsTest do
  use EventApp.DataCase

  alias EventApp.Events

  describe "events" do
    alias EventApp.Events.Event

    @valid_attrs %{comments: "some comments", date: "2010-04-17T14:00:00Z", description: "some description", link: "some link", name: "some name", responses: "some responses", updates: []}
    @update_attrs %{comments: "some updated comments", date: "2011-05-18T15:01:01Z", description: "some updated description", link: "some updated link", name: "some updated name", responses: "some updated responses", updates: []}
    @invalid_attrs %{comments: nil, date: nil, description: nil, link: nil, name: nil, responses: nil, updates: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Events.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Events.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Events.create_event(@valid_attrs)
      assert event.comments == "some comments"
      assert event.date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert event.description == "some description"
      assert event.link == "some link"
      assert event.name == "some name"
      assert event.responses == "some responses"
      assert event.updates == []
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, %Event{} = event} = Events.update_event(event, @update_attrs)
      assert event.comments == "some updated comments"
      assert event.date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert event.description == "some updated description"
      assert event.link == "some updated link"
      assert event.name == "some updated name"
      assert event.responses == "some updated responses"
      assert event.updates == []
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end
end
