defmodule Sample.Sample2 do
  alias ElixirToResoniteClient.InstructionCreation, as: F
  alias ElixirToResoniteClient.Socket

  def run do
    socket = Socket.connect!()

    F.join()
    |> Socket.send_frame(socket, 0)

    task_box(socket)
    task_del_box(socket)
  end

  def task_box(socket) do
    1..360//4
    |> Enum.to_list()
    |> run_frame_box(socket)
  end

  def run_frame_box([], _socket), do: nil

  def run_frame_box([h | t], socket) do
    c = :math.pi() / 180
    x = :math.sin(c * h * 2) * 10 + 10.0
    y = :math.cos(c * h) * 10 + 10.0

    F.init_frame()
    |> F.copy("Box", "TestBox#{h}")
    |> F.move("Box", x, x, y)
    |> Socket.send_frame(socket, 10)

    run_frame_box(t, socket)
  end

  def task_del_box(socket) do
    1..360//4
    |> Enum.to_list()
    |> run_frame_del_box(socket)
  end

  def run_frame_del_box([], _socket), do: nil

  def run_frame_del_box([h | t], socket) do
    F.init_frame()
    |> F.delete("TestBox#{h}")
    |> Socket.send_frame(socket, 10)

    run_frame_del_box(t, socket)
  end
end
