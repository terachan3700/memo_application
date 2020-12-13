# frozen_string_literal: true

require 'dotenv/load'
require 'pg'
require 'singleton'

class Memo
  include Singleton

  def initialize
    @connection = PG::Connection.new({ host: ENV['DB_HOST'],
                                       port: ENV['DB_PORT'],
                                       user: ENV['DB_USERNAME'],
                                       password: ENV['DB_PASSWORD'],
                                       dbname: ENV['DB_NAME'] })
  end

  def create(title, memo)
    @connection.prepare('create_memo', 'INSERT INTO memos(title, memo) VALUES( $1, $2);')
    @connection.exec_prepared('create_memo', [title, memo])
    @connection.exec('DEALLOCATE create_memo')
  end

  def select_all
    @connection.exec('SELECT * FROM memos')
  end

  def select(id)
    @connection.prepare('select_memo', 'SELECT * FROM memos WHERE ID = $1;')
    memo = @connection.exec_prepared('select_memo', [id])
    @connection.exec('DEALLOCATE select_memo')
    memo.first
  end

  def update(id, title, memo)
    @connection.prepare('update_memo', 'UPDATE memos SET title = $1 , memo = $2 WHERE ID = $3;')
    @connection.exec_prepared('update_memo', [title, memo, id])
    @connection.exec('DEALLOCATE update_memo')
  end

  def delete(id)
    @connection.prepare('delete_memo', 'DELETE FROM memos WHERE ID = $1;')
    @connection.exec_prepared('delete_memo', [id])
    @connection.exec('DEALLOCATE delete_memo')
  end
end
