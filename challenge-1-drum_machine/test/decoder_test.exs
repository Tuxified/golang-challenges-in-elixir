defmodule DecoderTest do
  use ExUnit.Case, async: true
  import Drum.Decoder

  test "decode pattern1" do
    patterns = [
    {"pattern_1.splice", "Saved with HW Version: 0.808-alpha
Tempo: 120.0
"},
    {"pattern_2.splice",
       "Saved with HW Version: 0.808-alpha
Tempo: 98.4
"},
    {"pattern_3.splice",
       "Saved with HW Version: 0.808-alpha
Tempo: 118.0
"}, {"pattern_4.splice",
       "Saved with HW Version: 0.909
Tempo: 240.0
"}
  ]

    for { filename, output } <- patterns do
      assert decode_file("test/fixtures/#{filename}") == output
    end
  end
end
