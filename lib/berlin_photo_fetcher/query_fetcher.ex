defmodule BerlinPhotoFetcher.QueryFetcher do
  alias BerlinPhotoFetcher.Unsplash.Producer, as: UnsplashProducer
  alias BerlinPhotoFetcher.Unsplash.Parser, as: UnsplashParser

  def build(query) do
    Stream.resource(
      fn -> fetch_page(build_url(query)) end,
      &process_page/1,
      fn _ -> nil end
    )
  end

  defp build_url(query) do
    "https://api.unsplash.com/search/photos?query=#{query}"
  end

  defp fetch_page(url) do
    response = UnsplashProducer.call(url)
    items = UnsplashParser.call(response)
    next_page_url = extract_next_page_url(response.headers["Link"])

    {items, next_page_url}
  end

  defp process_page({nil, nil}) do
    {:halt, nil}
  end

  defp process_page({nil, next_page_url}) do
    next_page_url
    |> fetch_page
    |> process_page
  end

  defp process_page({items, next_page_url}) do
    {items, {nil, next_page_url}}
  end

  defp extract_next_page_url(links_string) do
    links_string
    |> parse_links
    |> Map.fetch!("next")
  end

  defp parse_links(links_string) do
    links = String.split(links_string, ", ")

    Enum.map(links, fn link ->
      [_, name] = Regex.run(~r{rel="([a-z]+)"}, link)
      [_, url] = Regex.run(~r{<([^>]+)>}, link)

      {name, url}
    end)
    |> Enum.into(%{})
  end
end
