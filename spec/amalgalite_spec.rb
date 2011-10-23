require 'helper'
require 'adapter/amalgalite'

describe "Amalgalite adapter" do
  before do
    @client = Amalgalite::Database.new('test.db')
    @adapter = Adapter[:amalgalite].new(@client, :count => 100, :durantion => 50)
    @adapter.clear
  end

  let(:adapter) { @adapter }
  let(:client)  { @client }

  it_should_behave_like 'a marshaled adapter'

end