defmodule ElixirToResoniteClient do
  @moduledoc """
  Documentation for `ElixirToResoniteClient`.
  """
  alias Socket.Web

  @doc """
  Hello world.

  """
  def hello do
    Web.connect!("localhost", 4000, path: "/socket/websocket?token=undefined&vsn=2.0.0")
    |> join()
    |> move("Box", "1.0", "2.0", "1.0")
    |> move("Cylinder", "1.0", "2.0", "2.0")
    |> move("Box", "1.0", "3.0", "1")
    |> move("Box", "1.0", "4.0", "1")
    |> move("Box", "1.0", "5.0", "1")
    |> move("Cylinder", "1.0", "2.0", "3")
    |> move("Cylinder", "1.0", "2.0", "4")
    |> move("Cylinder", "1.0", "2.0", "5")

    :world
  end

  def move(socket, name, x, y, z) do
    data =
      create_field("move") <>
        create_field(name) <> create_field(x) <> create_field(y) <> create_field(z)

    send_data(socket, data)
  end

  def create_field(value) do
    (value <> String.duplicate(" ", 20))
    |> String.slice(0, 20)
  end

  def send_data(socket, data) do
    data = """
    ["3","4","resonite:lobby","new_msg",{"body":"#{data}"}]
    """

    Web.send!(socket, {:text, data})
    Process.sleep(250)
    socket
  end

  def join(socket) do
    phx_join = """
    ["3","3","resonite:lobby","phx_join",{}]
    """

    Web.send!(socket, {:text, phx_join})
    socket
  end
end
