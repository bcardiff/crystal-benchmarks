# Copied with little modifications from: https://github.com/attractivechaos/plb/blob/master/matmul/matmul_v1.rb

def matgen(rows, cols)
  tmp = 1.0f32 / rows / cols
  matrix_new(rows, cols) { |i, j| tmp * (i - j) * (i + j) }
end

def matrix_new(rows, cols, &block : -> Float32)
  Array.new(rows) { |row| Array(Float32).new(cols) { |col| yield row, col } }
end

def matmul(a, b)
  m = a.size
  n = a[0].size
  p = b[0].size
  # transpose
  b2 = Array.new(n) { Array.new(p, 0.0f32) }
  (0...n).each do |i|
    (0...p).each do |j|
      b2[j][i] = b[i][j]
    end
  end
  # multiplication
  c = Array.new(m) { Array.new(p, 0.0f32) }
  (0...m).each do |i|
    (0...p).each do |j|
      s = 0f32
      ai, b2j = a[i], b2[j]
      (0...n).each do |k|
        s += ai[k] * b2j[k]
      end
      c[i][j] = s
    end
  end
  c
end

n = (ARGV[0]? || 500).to_i
a = matgen(n, n)
b = matgen(n, n)
c = matmul(a, b)
puts c[n // 2][n // 2]
