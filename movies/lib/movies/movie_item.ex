defmodule Movies.MovieItem do
  def search(query) do
    response =
      HTTPoison.post!("http://localhost:7700/indexes/movies/search", Jason.encode!(%{q: query}), [
        {"Content-Type", "application/json"}
      ])

    body = Jason.decode!(response.body)

    hits = body["hits"]
    processing_time = body["processingTimeMs"]

    %{hits: hits, processing_time: processing_time}
  end

  def load_more(query, offset) do
    response =
      HTTPoison.post!(
        "http://localhost:7700/indexes/movies/search",
        Jason.encode!(%{q: query, offset: offset}),
        [
          {"Content-Type", "application/json"}
        ]
      )

    body = Jason.decode!(response.body)

    hits = body["hits"]
    processing_time = body["processingTimeMs"]

    %{hits: hits, processing_time: processing_time}
  end
end
