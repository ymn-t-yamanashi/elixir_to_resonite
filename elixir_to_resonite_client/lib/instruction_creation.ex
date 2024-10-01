defmodule ElixirToResoniteClient.InstructionCreation do
  def move(send_datas, name, x, y, z) do
    send_data(send_datas, "move", name, "#{x}", "#{y}", "#{z}")
  end

  def create_field(value) do
    (value <> String.duplicate(" ", 20))
    |> String.slice(0, 20)
  end

  def send_data(send_datas, instruction, name, argument1, argument2, argument3) do
    data =
      create_field(instruction) <>
        create_field(name) <>
        create_field(argument1) <> create_field(argument2) <> create_field(argument3)

    send_data(send_datas, data)
  end

  def send_data(send_datas, data) do
    data = """
    ["","","resonite:lobby","new_msg",{"body":"#{data}"}]
    """

    send_datas ++ [data]
  end

  def join() do
    phx_join = """
    ["","","resonite:lobby","phx_join",{}]
    """

    [[phx_join]]
  end
end
