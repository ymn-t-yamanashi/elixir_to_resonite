defmodule ElixirToResoniteClient.InstructionCreation do
  @moduledoc """
  This module assembles instructions to communicate with a Resonite environment.
  """

  import ElixirToResoniteClient.InstructionCore

  @doc """
  Move the 3D model object
  """
  def move(send_datas, name, x, y, z) do
    create_send_data(send_datas, "move", name, "#{x}", "#{y}", "#{z}")
  end

  @doc """
  Copy the 3D model object
  """
  def copy(send_datas, name, to_name) do
    create_send_data(send_datas, "copy", name, to_name, "", "")
  end

  @doc """
  Delete the 3D model object
  """
  def delete(send_datas, name) do
    create_send_data(send_datas, "delete", name, "", "", "")
  end

  @doc """
  Rotate the 3D model object
  """
  def rotate(send_datas, name, x, y, z) do
    create_send_data(send_datas, "rotate", name, "#{x}", "#{y}", "#{z}")
  end

  @doc """
  Size the 3D model object
  """
  def size(send_datas, name, x, y, z) do
    create_send_data(send_datas, "size", name, "#{x}", "#{y}", "#{z}")
  end

  @doc """
  Create box the 3D model object
  """
  def create_box(send_datas, name, x, y, z) do
    copy(send_datas, "Box", name)
    |> move(name, x, y, z)
  end

  @doc """
  Cylinder box the 3D model object
  """
  def create_cylinder(send_datas, name, x, y, z) do
    copy(send_datas, "Cylinder", name)
    |> move(name, x, y, z)
  end

  @doc """
  Initialize the animation to the first frame
  """
  def init_frame(), do: []

  @doc """
  Establishing a WebSocket connection
  """
  def join() do
    phx_join = base_data("phx_join", "")
    [phx_join]
  end
end
