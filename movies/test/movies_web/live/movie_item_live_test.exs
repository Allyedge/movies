defmodule MoviesWeb.MovieItemLiveTest do
  use MoviesWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "Index" do
    test "lists all movie_items", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/")

      assert html =~ "Movies"
    end
  end
end
