SIZE           = ARGV[0].to_i
MATMUL_WORKERS = ARGV[1].to_i

def matgen(rows, cols)
  tmp = 1.0f32 / rows / cols
  matrix_new(rows, cols) { |i, j| tmp * (i - j) * (i + j) }
end

def matrix_zero(rows, cols)
  Array.new(rows) { Array.new(cols, 0f32) }
end

def matrix_new(rows, cols, &block : -> Float32)
  Array.new(rows) { |row| Array(Float32).new(cols) { |col| yield row, col } }
end

a = matgen(SIZE, SIZE)
b = matgen(SIZE, SIZE)

r = matrix_zero(SIZE, SIZE)

ch_in = Channel({Int32, Int32}).new(10)
ch_out = Channel({Int32, Int32, Float32}).new(10)

MATMUL_WORKERS.times do
  spawn do
    loop do
      row, col = ch_in.receive
      m = 0f32
      SIZE.times do |i|
        m += a[row][i] * b[i][row]
      end
      ch_out.send({row, col, m})
    end
  end
end

spawn do
  SIZE.times do |row|
    SIZE.times do |col|
      ch_in.send({row, col})
    end
  end
end

(SIZE * SIZE).times do
  row, col, m = ch_out.receive
  r[row][col] = m
end

puts r[SIZE // 2][SIZE // 2]
