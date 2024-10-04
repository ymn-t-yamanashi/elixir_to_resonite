defmodule Sample.Sample3 do
  alias ElixirToResoniteClient.InstructionCreation, as: F
  alias ElixirToResoniteClient.Socket

  def run do
    socket = Socket.connect!()

    F.join()
    |> Socket.send_frame(socket, 0)

    task_box(socket)
    Process.sleep(2000)
  end

  def task_box(socket) do
    1..360//10
    |> Enum.to_list()
    |> run_frame_box(socket)
  end

  def run_frame_box([], socket), do: Enum.to_list(1..360//10) |> run_frame_box(socket)

  def run_frame_box([h | t], socket) do
    c = :math.pi() / 180
    x = :math.sin(c * h * 1.2) * 5 + 10.0
    y = :math.cos(c * h * 1.5) * 5 + 10.0

    F.init_frame()
    |> F.move("ParticleSystem", x, y, 2)
    |> F.move("ParticleSystem1", x, y, y)
    |> F.move("ParticleSystem2", x, y, x)
    |> F.move("ParticleSystem3", x, x, x)
    |> F.move("ParticleSystem4", y, y, x)
    |> Socket.send_frame(socket, 10)

    run_frame_box(t, socket)
  end
end
