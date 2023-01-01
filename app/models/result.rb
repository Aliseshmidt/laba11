# frozen_string_literal: true

class Result < ApplicationRecord
  validates :input, numericality: {
    only_integer: true,
    greater_than: 0,
    message: 'должно быть больше нуля'
  }

  validates :input, uniqueness: {
    message: 'уже есть в базе'
  }

end
