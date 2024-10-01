defmodule ElixirToResoniteClient.InstructionCreation do
  def move(send_datas, name, x, y, z) do
    data =
      create_field("move") <>
        create_field(name) <> create_field(x) <> create_field(y) <> create_field(z)

    send_data(send_datas, data)
  end

  def create_field(value) do
    (value <> String.duplicate(" ", 20))
    |> String.slice(0, 20)
  end

  def send_data(send_datas, data) do
    data = """
    ["3","4","resonite:lobby","new_msg",{"body":"#{data}"}]
    """
    send_datas ++ [data]
  end
end
