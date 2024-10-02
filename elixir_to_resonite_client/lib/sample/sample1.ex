defmodule Sample.Sample1 do
  alias ElixirToResoniteClient.InstructionCreation, as: F
  alias ElixirToResoniteClient.Socket

  def run do
    socket = Socket.connect!()

    F.join()
    |> Socket.send_frame(socket, 0)

    Task.async(fn -> task_box(socket) end)
    Task.async(fn -> task_cylinder(socket) end)
    Process.sleep(10000)
  end

  def task_box(socket) do
    1..360
    |> Enum.to_list()
    |> run_frame_box(socket)
  end

  def run_frame_box([], socket), do: Enum.to_list(1..360) |> run_frame_box(socket)

  def run_frame_box([h | t], socket) do
    c = :math.pi() / 180
    x = :math.sin(c * h * 2) * 5 + 5.0
    y = :math.cos(c * h) * 5 + 5.0

    F.init_frame()
    |> F.move("Box", x, x, y)
    |> F.create_instructions()
    |> Socket.send_instructions(socket, 10)

    run_frame_box(t, socket)
  end

  def task_cylinder(socket) do
    get_coordinate()
    |> run_frame_cylinder(socket)
  end

  def run_frame_cylinder([], socket), do: get_coordinate() |> run_frame_cylinder(socket)

  def run_frame_cylinder([h | t], socket) do
    F.init_frame()
    |> F.move("Cylinder", h, 2.0, 2.0)
    |> F.create_instructions()
    |> Socket.send_instructions(socket, 200)

    run_frame_cylinder(t, socket)
  end

  def get_coordinate() do
    Enum.to_list(1..10) ++ Enum.to_list(10..1//-1)
  end
end
