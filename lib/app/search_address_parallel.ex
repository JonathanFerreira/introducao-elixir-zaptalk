defmodule SearchAddressParallel do
  def start(ceps) do
    ceps
      |> Enum.map(&create_task/1) # Cria uma task para cada cep
      |> Enum.map(&Task.await/1)  # Processa a resposta de cada task
  end

  # Cria task
  defp create_task(cep) do
    Task.async(fn -> by_cep(cep) end)
  end

  # Realiza a requisição
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

  # Realiza o parse da response
  defp parse_json(%{"bairro" => bairro, "logradouro" => logradouro, "cidade" => cidade}) do
    IO.puts "#{logradouro}, #{bairro} - #{cidade}"
  end

  # Define a url
  defp url(cep) do
    "https://api.postmon.com.br/v1/cep/#{cep}"
  end
end
