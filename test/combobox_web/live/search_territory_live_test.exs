defmodule ComboboxWeb.Search_territoryLiveTest do
  use ComboboxWeb.ConnCase

  import Phoenix.LiveViewTest
  import Combobox.TerritoryFixtures

  @create_attrs %{code: "some code", name: "some name", category: "some category"}
  @update_attrs %{
    code: "some updated code",
    name: "some updated name",
    category: "some updated category"
  }
  @invalid_attrs %{code: nil, name: nil, category: nil}

  defp create_search_territory(_) do
    search_territory = search_territory_fixture()
    %{search_territory: search_territory}
  end

  describe "Index" do
    setup [:create_search_territory]

    test "lists all search_territories", %{conn: conn, search_territory: search_territory} do
      {:ok, _index_live, html} = live(conn, ~p"/search_territories")

      assert html =~ "Listing Search territories"
      assert html =~ search_territory.code
    end

    test "saves new search_territory", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/search_territories")

      assert index_live |> element("a", "New Search territory") |> render_click() =~
               "New Search territory"

      assert_patch(index_live, ~p"/search_territories/new")

      assert index_live
             |> form("#search_territory-form", search_territory: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#search_territory-form", search_territory: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/search_territories")

      html = render(index_live)
      assert html =~ "Search territory created successfully"
      assert html =~ "some code"
    end

    test "updates search_territory in listing", %{conn: conn, search_territory: search_territory} do
      {:ok, index_live, _html} = live(conn, ~p"/search_territories")

      assert index_live
             |> element("#search_territories-#{search_territory.id} a", "Edit")
             |> render_click() =~
               "Edit Search territory"

      assert_patch(index_live, ~p"/search_territories/#{search_territory}/edit")

      assert index_live
             |> form("#search_territory-form", search_territory: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#search_territory-form", search_territory: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/search_territories")

      html = render(index_live)
      assert html =~ "Search territory updated successfully"
      assert html =~ "some updated code"
    end

    test "deletes search_territory in listing", %{conn: conn, search_territory: search_territory} do
      {:ok, index_live, _html} = live(conn, ~p"/search_territories")

      assert index_live
             |> element("#search_territories-#{search_territory.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#search_territories-#{search_territory.id}")
    end
  end

  describe "Show" do
    setup [:create_search_territory]

    test "displays search_territory", %{conn: conn, search_territory: search_territory} do
      {:ok, _show_live, html} = live(conn, ~p"/search_territories/#{search_territory}")

      assert html =~ "Show Search territory"
      assert html =~ search_territory.code
    end

    test "updates search_territory within modal", %{
      conn: conn,
      search_territory: search_territory
    } do
      {:ok, show_live, _html} = live(conn, ~p"/search_territories/#{search_territory}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Search territory"

      assert_patch(show_live, ~p"/search_territories/#{search_territory}/show/edit")

      assert show_live
             |> form("#search_territory-form", search_territory: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#search_territory-form", search_territory: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/search_territories/#{search_territory}")

      html = render(show_live)
      assert html =~ "Search territory updated successfully"
      assert html =~ "some updated code"
    end
  end
end
