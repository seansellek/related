require 'spec_helper'

describe Related::Tuple do
  let(:tuple) { Tuple.new(['Amy', 16, 'female']) }
  let(:schema) { Schema.new(name: String, age: 16, gender: 'female') }
  context '#[]' do
    it 'when given name and schema returns value' do
      expect(tuple[:name, schema]).to eq('Amy')
    end
    it 'when given index returns value' do
      expect(tuple[0]).to eq('Amy')
    end
  end

  context '#values' do
    it 'returns an array of values' do
      expect(tuple.values).to eq(['Amy', 16, 'female'])
    end
  end

  context '#attributes' do
    it 'returns a hash of attributes' do
      expect(tuple.attributes(schema)).to eq(name: 'Amy', age: 16, gender: 'female')
    end
  end

  context '#==' do
    it 'matches against values when given array' do
      expect(tuple).to eq(['Amy', 16, 'female'])
    end
  end

  context '#+' do
    let(:result) { Tuple.new(['Amy', 16, 'female', 'Miami', 'Florida']) }
    it 'combines values of other tuple and returns a new Tuple' do
      tuple2 = Tuple.new(['Miami', 'Florida'])
      expect(tuple + tuple2).to eq(result)
    end

    it 'is not associative' do
      tuple2 = Tuple.new(['Miami', 'Florida'])
      expect(tuple2 + tuple).to_not eq(result)
    end
  end
  context '#project' do
    it 'when given schema and attribute names returns filtered tuple, respecting new order' do
      expect( tuple.project(schema, [:age, :name]).values ).to eq([16, 'Amy'])
    end
  end
end
