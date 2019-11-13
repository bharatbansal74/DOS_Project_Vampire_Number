defmodule Vampire do
 def initdistribute(numberlist,gen_id) do
  numberlist
  |> Enum.map(fn number -> spawn_link(Distribution, :work, [number,self(),gen_id]) end)
  get_response(length(numberlist), 0,gen_id) 
  |> Enum.sort(fn [a|_],[b|_] -> a <= b end)
  |> Enum.each(fn [a|b] -> IO.puts "#{a} " <> b end)
  end

  def get_response(total, rcvd,gen_id) do
      if(total == rcvd) do
          Server.fetch(gen_id)
      else
        receive do
          {:done} -> get_response(total,rcvd+1,gen_id)
        end
      end
  end

  def vampire_fangs(n) do
    initialfactor = trunc(n /:math.pow(10, div(stringlength(n), 2)))
    lastfactor  = :math.sqrt(n) |> round
    for i <- initialfactor .. lastfactor, rem(n, i) == 0, do: {i, div(n, i)}
  end

  def vampire_numbercheck(n) do
    cond do 
      rem(stringlength(n), 2) != 0 -> [n]
      true -> 
      midlength = div(length(to_char_list(n)), 2)
      orderedstring = Enum.sort(String.codepoints("#{n}"))
      fangs = Enum.filter(vampire_fangs(n), fn {f1, f2} ->
        stringlength(f1) == midlength && stringlength(f2) == midlength &&
        Enum.count([f1, f2], fn x -> rem(x, 10) == 0 end) != 2 &&
        Enum.sort(String.codepoints("#{f1}#{f2}")) == orderedstring
      end)
      s = fangs |> Enum.reduce("", fn {a,b},acc ->"#{a} #{b} "<> acc end) |> String.trim
      [n|s]
    end
  end        

  defp stringlength(n), do: length(to_char_list(n))
end       

 
