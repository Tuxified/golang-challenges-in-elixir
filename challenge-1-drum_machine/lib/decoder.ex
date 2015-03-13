defmodule Drum.Decoder do

  def decode_file(path) do
    binary_content = File.read! path
    << "SPLICE",
      raw_size    :: integer-size(64)-big,
      raw_version :: binary-size(32),
      raw_tempo   :: float-size(32)-little,
      raw_sheet   :: binary >> = binary_content

    version = raw_version |> stringify_version
    sheet = raw_sheet |> decode_sheet
    tempo = raw_tempo |> stringify_tempo
    "Saved with HW Version: #{version}
Tempo: #{tempo}
"
  end

  defp decode_sheet(<< track_id :: integer-size(8), word_size :: integer-size(32), track :: binary >>) do
    << track_name :: binary-size(word_size), track_pattern :: binary-size(16), rest :: binary >> = track
  end

  defp stringify_version(raw_version), do: raw_version |> to_char_list |> Enum.reject &(&1 == 0)
  defp stringify_tempo(raw_tempo), do: raw_tempo |> Float.round(1)
end
