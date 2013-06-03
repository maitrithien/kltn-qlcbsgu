Cách 1:
s = "1,3...5,8"
p s.split(',').map { |n|
  if n.scan('...').empty?
    n.to_i
  else
    Range.new(*n.split('...', 2)).to_a.map { |i| i.to_i}
  end
}.flatten

# => [1, 3, 4, 5, 8]

Cách 2:
def magick(str)
  str.split(",").map do |item|
    item.scan(/(\d+)(\.+)(\d+)/)
    if $1
      Range.new($1.to_i, $3.to_i, $2 == "...").to_a
    else
      item.to_i
    end
  end.flatten
end

s1 = "1,3..5,8"
s2 = "1,3...5,8,20,100, 135"
magick(s1)
#=> [1, 3, 4, 5, 8]
magick(s2)
#=> [1, 3, 4, 8, 20, 100, 135]