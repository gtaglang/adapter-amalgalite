require 'adapter'
require 'amalgalite'

module Adapter
  module Amalgalite
    def key?(key)
      !client.first_value_from(%{SELECT value FROM datastore WHERE key = ?}, key_for(key)).nil?
    end
    def read(key)
      if value = client.first_value_from(%{SELECT value FROM datastore WHERE key = ?}, key_for(key))
        decode(value.to_string_io.string)
      else
        nil
      end
    end
    def write(key, value)
      column = client.schema.tables['datastore'].columns['value']
      client.execute(%{REPLACE INTO datastore (key, value) VALUES (?, ?)}, [key_for(key), ::Amalgalite::Blob.new( :io => StringIO.new(encode(value)), :column => column )])
      value
    end
    def delete(key)
      read(key).tap{client.execute(%{DELETE FROM datastore WHERE key = ?}, key_for(key))}
    end
    def clear
      client.execute(%{DROP TABLE IF EXISTS datastore})
      client.execute(%{CREATE TABLE IF NOT EXISTS datastore (key TEXT NOT NULL UNIQUE, value BLOB)})
      client.busy_handler(::Amalgalite::BusyTimeout.new(options[:count] = 100, options[:duration] = 50))
    end
  end
end

Adapter.define(:amalgalite, Adapter::Amalgalite)