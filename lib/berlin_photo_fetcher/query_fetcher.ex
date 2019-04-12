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
    IO.puts("FETCHING #{url}")
    response = UnsplashProducer.call(url)

    if response.status_code == 403 do
      Process.sleep(60000)
      {nil, url}
    else
      items = UnsplashParser.call(response)
      next_page_url = extract_next_page_url(response.headers["Link"])

      {items, next_page_url}
    end
  end

  defp process_page({nil, nil}) do
    IO.puts("DONE!!!")
    {:halt, nil}
  end

  defp process_page({nil, next_page_url}) do
    IO.puts("PROCESSING PAGE, NO MORE  OTHER RESULTS")

    next_page_url
    |> fetch_page
    |> process_page
  end

  defp process_page({items, next_page_url}) do
    IO.puts("PROCESSING PAGE, OTHER RESULTS")
    {items, {nil, next_page_url}}
  end

  defp extract_next_page_url(links_string) do
    next_link =
      links_string
      |> parse_links
      |> Map.fetch("next")

    case next_link do
      {:ok, key} -> key
      :error -> nil
    end
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
