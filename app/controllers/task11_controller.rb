# frozen_string_literal: true

# class for calc
class Task11Controller < ApplicationController
  def input; end

  def output
    showdb if params[:getdb] && (params[:getdb]['checked'] == '1')
    @input = params[:digit].to_i
    res = Result.find_by(input: @input)
    if res
      @result = ActiveSupport::JSON.decode(res.output)
    else
      @result = []
      find_armstrongs(params[:digit].to_i).each_with_index do |val, indx|
        @result.append([number: val, index: indx + 1])
      end
      add_to_db(@input, @result)
    end
  end

  def xml
    results = Result.all.map do |result|
      { input: result.input, output: result.output }
    end
    render xml: results
  end

  private

  def find_armstrongs(number)
    (1..Float::INFINITY).lazy.drop_while { |x| x.digits.size < number }
                        .take_while { |x| x.digits.size == number }
                        .select { |x| armstrong?(x) }.force
  end

  def armstrong?(number)
    number.digits.sum { |x| x**number.digits.size } == number
  end

  def add_to_db(input, result)
    local_res = Result.create input: input, output: ActiveSupport::JSON.encode(result)
    local_res.save
  end

  def showdb
    @db = Result.all
    render json: @db
  end
end
