defmodule MoviesWeb.MovieItemLive.Index do
  use MoviesWeb, :live_view

  alias Movies.MovieItem

  @impl true
  def mount(_params, _session, socket) do
    result = MovieItem.search("")

    {:ok,
     socket
     |> assign(:form, %{})
     |> assign(:results, result.hits)
     |> assign(:processing_time, result.processing_time)}
  end

  @impl true
  def handle_event("search", %{"search" => search}, socket) do
    result = MovieItem.search(search)

    {:noreply,
     socket
     |> assign(:results, result.hits)
     |> assign(:processing_time, result.processing_time)}
  end

  @impl true
  def handle_event("load", _, socket) do
    result = MovieItem.load_more(socket.assigns.form["search"], length(socket.assigns.results))

    movies = socket.assigns.results ++ result.hits

    {:noreply,
     socket
     |> assign(:results, movies)
     |> assign(:processing_time, result.processing_time)}
  end
end
