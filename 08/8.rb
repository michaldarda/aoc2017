register = Hash.new(0)
max = 0

File.read("input").each_line do |line|
  a = line.split(" ")

  register_name = a.first
  operation = a[1] == "inc" ? "+" : "-"
  operation_value = a[2].to_i
  condition_left = a[4]
  condition_operator = a[5];
  condition_right = a[6].to_i

  register_value = register[register_name]
  condition_left_value = register[condition_left]

  condition = condition_left_value.send(condition_operator, condition_right)

  if condition
    register[register_name] = register[register_name].send(operation, operation_value)
  end
  max = register.values.max if max < register.values.max
end

require 'pp'

pp register.max_by { |(k, v)| v }.last
pp max
