defmodule DecoderTest do
  use ExUnit.Case, async: true
  import Drum.Decoder

  test "decode pattern1" do
    patterns = [
      {"pattern_1.splice",
        """
        Saved with HW Version: 0.808-alpha
        Tempo: 120.0
        (0) kick	|x---|x---|x---|x---|
        (1) snare	|----|x---|----|x---|
        (2) clap	|----|x-x-|----|----|
        (3) hh-open	|--x-|--x-|x-x-|--x-|
        (4) hh-close	|x---|x---|----|x--x|
        (5) cowbell	|----|----|--x-|----|
        """,
      },
      {"pattern_2.splice",
        """
        Saved with HW Version: 0.808-alpha
        Tempo: 98.4
        (0) kick	|x---|----|x---|----|
        (1) snare	|----|x---|----|x---|
        (3) hh-open	|--x-|--x-|x-x-|--x-|
        (5) cowbell	|----|----|x---|----|
        """,
      },
      {"pattern_3.splice",
        """
        Saved with HW Version: 0.808-alpha
        Tempo: 118.0
        (40) kick	|x---|----|x---|----|
        (1) clap	|----|x---|----|x---|
        (3) hh-open	|--x-|--x-|x-x-|--x-|
        (5) low-tom	|----|---x|----|----|
        (12) mid-tom	|----|----|x---|----|
        (9) hi-tom	|----|----|-x--|----|
        """,
      },
      {"pattern_4.splice",
        """
        Saved with HW Version: 0.909
        Tempo: 240.0
        (0) SubKick	|----|----|----|----|
        (1) Kick	|x---|----|x---|----|
        (99) Maracas	|x-x-|x-x-|x-x-|x-x-|
        (255) Low Conga	|----|x---|----|x---|
        """,
      },
      {"pattern_5.splice",
        """
        Saved with HW Version: 0.708-alpha
        Tempo: 999.0
        (1) Kick	|x---|----|x---|----|
        (2) HiHat	|x-x-|x-x-|x-x-|x-x-|
        """,
      },
    ]

    for { filename, output } <- patterns do
      assert decode_file("test/fixtures/#{filename}") == output
    end
  end
end
