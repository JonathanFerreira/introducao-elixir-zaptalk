defmodule SearchAddress do
  def start do
    File.stream!('ceps.txt')
      |> Enum.map(&(by_cep/1))
  end

  defp by_cep(cep) do
    case HTTPoison.get(url(cep)) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body |> JSON.decode! |> parse_json
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found :("
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
      _ -> IO.puts "Deu ruim"
    end
  end

  defp parse_json(%{"bairro" => bairro, "logradouro" => logradouro, "cidade" => cidade}) do
    IO.puts "#{logradouro}, #{bairro} - #{cidade}"
  end

  defp url(cep) do
    "https://api.postmon.com.br/v1/cep/#{cep}"
  end
end
