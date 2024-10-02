defmodule ElixirToResoniteClient.InstructionCreation do
  @moduledoc """
  This module assembles instructions to communicate with a Resonite environment.
  """

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
  Initialize the animation to the first frame
  """
  def init_frame(), do: []

  @doc """
  Creating a block of instructions
  """
  def create_instructions(instruction), do: [instruction]

  @doc """
  Create a field
  """
  def create_field(value) do
    (value <> String.duplicate(" ", 20))
    |> String.slice(0, 20)
  end

  @doc """
  Create a send data
  """
  def create_send_data(send_datas, instruction, name, argument1, argument2, argument3) do
    [instruction, name, argument1, argument2, argument3]
    |> Enum.map(&create_field(&1))
    |> List.to_string()
    |> then(&create_send_data(send_datas, &1))
  end

  def create_send_data(send_datas, data) do
    data = base_data("new_msg", "\"body\":\"#{data}\"")

    send_datas ++ [data]
  end

  @doc """
  Establishing a WebSocket connection
  """
  def join() do
    phx_join = base_data("phx_join", "")
    [phx_join]
  end

  @doc """
  Creating a base data structure for WebSocket communication
  """
  def base_data(instruction, data) do
    """
    ["","","resonite:lobby","#{instruction}",{#{data}}]
    """
  end
end
