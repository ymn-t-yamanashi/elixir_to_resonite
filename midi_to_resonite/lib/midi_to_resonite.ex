defmodule MidiToResonite do
  alias ElixirToResoniteClient.InstructionCreation, as: F
  alias ElixirToResoniteClient.Socket

  @moduledoc """
  Documentation for `MidiToResonite`.
  """

  @doc """
  Hello world.
  """
  def hello do
    socket = Socket.connect!()

    F.join()
    |> Socket.send_frame(socket, 0)

    F.init_frame()
    |> F.move("Box", 1, 1, 2)
    |> Socket.send_frame(socket, 10)

    {:ok, input} = PortMidi.open(:input, "Midi Through Port-0")
    PortMidi.listen(input, self())
    midi_in(input, socket)

    PortMidi.close(:output, input)

    :world
  end

  def midi_in(input, socket) do
    receive do
      data ->
        get_data(data, socket)
        midi_in(input, socket)
    end
  end

  def get_data({_, []}, _), do: nil

  def get_data({_, data}, socket) do
    data
    |> Enum.each(fn x -> get_midi_data(x, socket) end)
  end

  def get_midi_data({{_, x, _}, _}, socket) do
    v =
      case x do
        48 -> 1
        53 -> 2
        60 -> 3
      end

    F.init_frame()
    |> F.move("Box", 1, v, 1)
    |> Socket.send_frame(socket, 0)

    IO.inspect(v)
  end
end
