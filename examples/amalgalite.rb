require 'rubygems'
require 'pathname'

root_path = Pathname(__FILE__).dirname.join('..').expand_path
lib_path  = root_path.join('lib')
$:.unshift(lib_path)

require 'adapter/amalgalite'

client  = Amalgalite::Database.new('tmp/test.db')
adapter = Adapter[:amalgalite].new(client)
adapter.clear

adapter.write('foo', 'bar')
puts 'Should be bar: ' + adapter.read('foo').inspect

adapter.delete('foo')
puts 'Should be nil: ' + adapter.read('foo').inspect

adapter.write('foo', 'bar')
adapter.clear
puts 'Should be nil: ' + adapter.read('foo').inspect

puts 'Should be bar: ' + adapter.fetch('foo', 'bar')
puts 'Should be bar: ' + adapter.read('foo')