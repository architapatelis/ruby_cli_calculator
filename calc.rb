# Frist Split the given equation into Integers and Symbols.
# Then Divide or Multiply
  # In the equations if division comes before multiplication then perform that first,
  # else if multiplication comes before division then perform that first
# Once divsion and multiplication is completed, loop through the array and perform addition and subtraction in the order in which it appears.

def main
  puts "What would you like to Calculate?(e.g 1+4*3-4): "

  input = gets.chomp

  if input.match(/\s/) #if input has space in it
    @calc = input.split(" ")
    @calc.each do |x|
      if x.length > 1
        if /[-+\/\*]/.match(x) # same as: x.include?("+") || x.include?("-") || x.include?("*") || x.include?("/")
          new_index = @calc.index(x)
          @calc.delete_at(new_index)
          new_array = x.split( /\s+|\b/ ) # split entries that don't have space between them: e.g. +50*2

          new_array.each do |val|
            if val == "+" || val == "-" || val == "*" || val == "/"
              @calc.insert(new_index, val)
              new_index += 1
            else
              @calc.insert(new_index, val)
              new_index += 1
            end
          end
        end
      end
    end
  else # if input doesn't have space in it
    @calc = input.split( /\s+|\b/ )
  end

  # convert the array entries into Integers and Symbols
  @calc.map!.with_index do |val, i|
    if i.even?
      val.to_i
    else
      val.to_sym
    end
  end

  if input == "exit"
    puts "Goodbye!"
    exit(0)
  end

  # first take care of the division and multiplications
  if @calc.include?(:/) && @calc.include?(:*)
    if @calc.index(:/) < @calc.index(:*)
      #div(@calc)
      div_or_mult(@calc, :/)
    else
      #mult(@calc)
      div_or_mult(@calc, :*)
    end
  end
  if @calc.include?(:/)
    #div(@calc)
    div_or_mult(@calc, :/)
  end
  if @calc.include?(:*)
    #mult(@calc)
    div_or_mult(@calc, :*)
  end

  p @calc
  total = @calc[0]

  # Once the division and multiplication is done, loop through the array and add or substract
  for i in 1..@calc.length-1
    if @calc[i] == :-
      total -= @calc[i+1]
    end

    if @calc[i] == :+
      total += @calc[i+1]
    end
  end

  p "TOTAL = #{total}"

  main
end

def div_or_mult(arr, sym)
  p @calc
  i = @calc.index(sym)
  if sym == :/
    val = @calc[i-1] / @calc[i+1]
  else
    val = @calc[i-1] * @calc[i+1]
  end
  new_index = i-1
  @calc.slice!(i-1..i+1)
  @calc.insert(new_index, val)
  if @calc.include?(sym)
    div_or_mult(@calc, sym)
  end
end

main
