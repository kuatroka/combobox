defmodule ComboboxWeb.StateLiveTest do
  use ComboboxWeb.ConnCase

  import Phoenix.LiveViewTest
  import Combobox.TerritoryFixtures

  @create_attrs %{code: "some code", state_id: 42, state_name: "some state_name", country_code: "some country_code"}
  @update_attrs %{code: "some updated code", state_id: 43, state_name: "some updated state_name", country_code: "some updated country_code"}
  @invalid_attrs %{code: nil, state_id: nil, state_name: nil, country_code: nil}

  defp create_state(_) do
    state = state_fixture()
    %{state: state}
  end

  describe "Index" do
    setup [:create_state]

    test "lists all states", %{conn: conn, state: state} do
      {:ok, _index_live, html} = live(conn, ~p"/states")

      assert html =~ "Listing States"
      assert html =~ state.code
    end

    test "saves new state", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/states")

      assert index_live |> element("a", "New State") |> render_click() =~
               "New State"

      assert_patch(index_live, ~p"/states/new")

      assert index_live
             |> form("#state-form", state: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#state-form", state: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/states")

      html = render(index_live)
      assert html =~ "State created successfully"
      assert html =~ "some code"
    end

    test "updates state in listing", %{conn: conn, state: state} do
      {:ok, index_live, _html} = live(conn, ~p"/states")

      assert index_live |> element("#states-#{state.id} a", "Edit") |> render_click() =~
               "Edit State"

      assert_patch(index_live, ~p"/states/#{state}/edit")

      assert index_live
             |> form("#state-form", state: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#state-form", state: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/states")

      html = render(index_live)
      assert html =~ "State updated successfully"
      assert html =~ "some updated code"
    end

    test "deletes state in listing", %{conn: conn, state: state} do
      {:ok, index_live, _html} = live(conn, ~p"/states")

      assert index_live |> element("#states-#{state.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#states-#{state.id}")
    end
  end

  describe "Show" do
    setup [:create_state]

    test "displays state", %{conn: conn, state: state} do
      {:ok, _show_live, html} = live(conn, ~p"/states/#{state}")

      assert html =~ "Show State"
      assert html =~ state.code
    end

    test "updates state within modal", %{conn: conn, state: state} do
      {:ok, show_live, _html} = live(conn, ~p"/states/#{state}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit State"

      assert_patch(show_live, ~p"/states/#{state}/show/edit")

      assert show_live
             |> form("#state-form", state: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#state-form", state: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/states/#{state}")

      html = render(show_live)
      assert html =~ "State updated successfully"
      assert html =~ "some updated code"
    end
  end
end
