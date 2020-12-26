# frozen_string_literal: true

class DataFile
  MEMO_DATA_FILE_PATH = './data/memos.csv'
  MAX_ID_FILE_PATH = './data/max_id.txt'

  def self.read_csv_data
    csv_options = {
      headers: true,
      header_converters: :symbol,
      encoding: Encoding::UTF_8
    }
    CSV.read(MEMO_DATA_FILE_PATH, csv_options)
  end

  def self.select_memo(id)
    csv = read_csv_data
    csv.find { |row| row[:id] == id }
  end

  def self.create_new_memo(id, title, memo)
    CSV.open(MEMO_DATA_FILE_PATH, 'a') do |memo_data|
      memo_data.puts [id, title, memo]
    end
  end

  def self.increment_max_id
    max_id = File.open(MAX_ID_FILE_PATH, 'r', &:read).to_i + 1
    File.open(MAX_ID_FILE_PATH, 'w') { |id| id.puts(max_id) }
    max_id
  end

  def self.delete_memo(id)
    memo_table = CSV.table(MEMO_DATA_FILE_PATH)
    memo_table.delete_if { |row| row[:id] == id.to_i }
    File.write(MEMO_DATA_FILE_PATH, memo_table)
  end

  def self.update_memo(id, title, memo)
    memo_table = CSV.table(MEMO_DATA_FILE_PATH)
    update_index = memo_table.find_index { |row| row[:id] == id.to_i }
    memo_table[update_index][:title] = title
    memo_table[update_index][:memo] = memo
    File.write(MEMO_DATA_FILE_PATH, memo_table)
  end
end
