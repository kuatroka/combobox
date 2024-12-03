defmodule ComboboxWeb.CityLiveTest do
  use ComboboxWeb.ConnCase

  import Phoenix.LiveViewTest
  import Combobox.TerritoryFixtures

  @create_attrs %{city_id: 42, city_name: "some city_name", country_code: "some country_code", state_code: "some state_code", latitude: "some latitude", longitude: "some longitude"}
  @update_attrs %{city_id: 43, city_name: "some updated city_name", country_code: "some updated country_code", state_code: "some updated state_code", latitude: "some updated latitude", longitude: "some updated longitude"}
  @invalid_attrs %{city_id: nil, city_name: nil, country_code: nil, state_code: nil, latitude: nil, longitude: nil}

  defp create_city(_) do
    city = city_fixture()
    %{city: city}
  end

  describe "Index" do
    setup [:create_city]

    test "lists all cities", %{conn: conn, city: city} do
      {:ok, _index_live, html} = live(conn, ~p"/cities")

      assert html =~ "Listing Cities"
      assert html =~ city.city_name
    end

    test "saves new city", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/cities")

      assert index_live |> element("a", "New City") |> render_click() =~
               "New City"

      assert_patch(index_live, ~p"/cities/new")

      assert index_live
             |> form("#city-form", city: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#city-form", city: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/cities")

      html = render(index_live)
      assert html =~ "City created successfully"
      assert html =~ "some city_name"
    end

    test "updates city in listing", %{conn: conn, city: city} do
      {:ok, index_live, _html} = live(conn, ~p"/cities")

      assert index_live |> element("#cities-#{city.id} a", "Edit") |> render_click() =~
               "Edit City"

      assert_patch(index_live, ~p"/cities/#{city}/edit")

      assert index_live
             |> form("#city-form", city: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#city-form", city: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/cities")

      html = render(index_live)
      assert html =~ "City updated successfully"
      assert html =~ "some updated city_name"
    end

    test "deletes city in listing", %{conn: conn, city: city} do
      {:ok, index_live, _html} = live(conn, ~p"/cities")

      assert index_live |> element("#cities-#{city.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#cities-#{city.id}")
    end
  end

  describe "Show" do
    setup [:create_city]

    test "displays city", %{conn: conn, city: city} do
      {:ok, _show_live, html} = live(conn, ~p"/cities/#{city}")

      assert html =~ "Show City"
      assert html =~ city.city_name
    end

    test "updates city within modal", %{conn: conn, city: city} do
      {:ok, show_live, _html} = live(conn, ~p"/cities/#{city}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit City"

      assert_patch(show_live, ~p"/cities/#{city}/show/edit")

      assert show_live
             |> form("#city-form", city: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#city-form", city: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/cities/#{city}")

      html = render(show_live)
      assert html =~ "City updated successfully"
      assert html =~ "some updated city_name"
    end
  end
end
