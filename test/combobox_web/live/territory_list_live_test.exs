defmodule ComboboxWeb.TerritoryListLiveTest do
  use ComboboxWeb.ConnCase

  import Phoenix.LiveViewTest
  import Combobox.TerritoryFixtures

  @create_attrs %{code: "some code", name: "some name", category: "some category"}
  @update_attrs %{code: "some updated code", name: "some updated name", category: "some updated category"}
  @invalid_attrs %{code: nil, name: nil, category: nil}

  defp create_territory_list(_) do
    territory_list = territory_list_fixture()
    %{territory_list: territory_list}
  end

  describe "Index" do
    setup [:create_territory_list]

    test "lists all territories_list", %{conn: conn, territory_list: territory_list} do
      {:ok, _index_live, html} = live(conn, ~p"/territories_list")

      assert html =~ "Listing Territories list"
      assert html =~ territory_list.code
    end

    test "saves new territory_list", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/territories_list")

      assert index_live |> element("a", "New Territory list") |> render_click() =~
               "New Territory list"

      assert_patch(index_live, ~p"/territories_list/new")

      assert index_live
             |> form("#territory_list-form", territory_list: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#territory_list-form", territory_list: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/territories_list")

      html = render(index_live)
      assert html =~ "Territory list created successfully"
      assert html =~ "some code"
    end

    test "updates territory_list in listing", %{conn: conn, territory_list: territory_list} do
      {:ok, index_live, _html} = live(conn, ~p"/territories_list")

      assert index_live |> element("#territories_list-#{territory_list.id} a", "Edit") |> render_click() =~
               "Edit Territory list"

      assert_patch(index_live, ~p"/territories_list/#{territory_list}/edit")

      assert index_live
             |> form("#territory_list-form", territory_list: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#territory_list-form", territory_list: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/territories_list")

      html = render(index_live)
      assert html =~ "Territory list updated successfully"
      assert html =~ "some updated code"
    end

    test "deletes territory_list in listing", %{conn: conn, territory_list: territory_list} do
      {:ok, index_live, _html} = live(conn, ~p"/territories_list")

      assert index_live |> element("#territories_list-#{territory_list.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#territories_list-#{territory_list.id}")
    end
  end

  describe "Show" do
    setup [:create_territory_list]

    test "displays territory_list", %{conn: conn, territory_list: territory_list} do
      {:ok, _show_live, html} = live(conn, ~p"/territories_list/#{territory_list}")

      assert html =~ "Show Territory list"
      assert html =~ territory_list.code
    end

    test "updates territory_list within modal", %{conn: conn, territory_list: territory_list} do
      {:ok, show_live, _html} = live(conn, ~p"/territories_list/#{territory_list}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Territory list"

      assert_patch(show_live, ~p"/territories_list/#{territory_list}/show/edit")

      assert show_live
             |> form("#territory_list-form", territory_list: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#territory_list-form", territory_list: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/territories_list/#{territory_list}")

      html = render(show_live)
      assert html =~ "Territory list updated successfully"
      assert html =~ "some updated code"
    end
  end
end
