defmodule MagentistWeb.DataController do
  use MagentistWeb, :controller

  @defaults %{"filename" => "magento"}

  def index(conn, %{"config" => config}) do
    config = Map.merge(@defaults, Poison.decode!(config))

    generate(config)
    |> CSV.encode
    |> Enum.into(response(conn, config["filename"]))
  end

  defp generate(config) do
    Stream.concat(
      [[config["columns"]],
      Magentist.Generator.generate(config)]
    )
  end

  defp response(conn, filename) do
    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", ~s(attachment; filename="#{filename}.csv"))
    |> send_chunked(200)
  end
end
