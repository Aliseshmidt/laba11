# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Result, type: :model do
  it 'checks performance of the model' do
    input = 3
    res = Result.find_by(input: 3)
    res&.destroy
    result = [[153, 1], [370, 2], [371, 3], [407, 4]]
    local_res = Result.create input: input, output: ActiveSupport::JSON.encode(result)
    local_res.save
    res = Result.find_by(input: 3)
    db_result = ActiveSupport::JSON.decode(res.output)
    expect(db_result).to eq(result)
  end

  it 'checks performance of the model' do
    input = 3
    res = Result.find_by(input: 3)
    res&.destroy
    result = [[153, 1], [370, 2], [371, 3], [407, 4]]
    result2 = [[153, 1], [370, 2]]
    local_res = Result.create! input: input, output: ActiveSupport::JSON.encode(result)

    expect do
      local_res = Result.create! input:, output: ActiveSupport::JSON.encode(result2)
    end.to raise_error
  end
end
