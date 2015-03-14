defmodule Drum.Track do
  defstruct name: "", id: 0, pattern: []
end

defimpl String.Chars, for: Drum.Track do
  def to_string(track), do: "(#{track.id}) #{track.name}\t|#{pattern_to_string(track.pattern)}|"

  defp pattern_to_string(pattern) do
    pattern
    |> Enum.map(&(if &1 == 0, do: "-", else: "x"))
    |> Enum.chunk(4)
    |> Enum.join "|"
  end
end

defmodule Drum.Decoder do
  def decode_file(path) do
    binary_content = File.read! path

    << "SPLICE",
      sheet_size  :: integer-size(64)-big,
      raw_version :: binary-size(32),
      raw_tempo   :: float-size(32)-little,
      rest        :: binary >> = binary_content

    # correct sheet_size by subtracting version & temp
    sheet_size = sheet_size - 32 - 4
    << raw_sheet  :: binary-size(sheet_size), _junk :: binary >> = rest

    version = stringify_version raw_version
    tracks =  decode_sheet raw_sheet, []
    tempo =  stringify_tempo raw_tempo

    """
    Saved with HW Version: #{version}
    Tempo: #{tempo}
    """ <> Enum.map_join(tracks, "\n", &String.Chars.to_string/1) <> "\n"
  end

  defp decode_sheet(<< track_id :: integer-size(8), word_size :: integer-size(32), track :: binary >>, tracks) do
    << track_name :: binary-size(word_size), track_pattern :: binary-size(16), rest :: binary >> = track
    new_track = %Drum.Track{ id: track_id, name: track_name, pattern: to_char_list(track_pattern) }
    decode_sheet(rest, [new_track | tracks])
  end

  defp decode_sheet("", tracks), do: Enum.reverse tracks

  defp stringify_version(raw_version), do: raw_version |> to_char_list |> Enum.reject &(&1 == 0)
  defp stringify_tempo(raw_tempo), do: raw_tempo |> Float.round(1)
end
