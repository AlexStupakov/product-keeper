# frozen_string_literal: true

class Product
  include Mongoid::Document

  field :product_name, type: String
  field :photo_url, type: String
  field :barcode, type: String
  field :price_cents, type: Integer
  field :producer, type: String

  validates :product_name, presence: true
  validates :photo_url, presence: true
  validates :barcode, presence: true
  validates :producer, presence: true

  index(producer: 'text')

  def self.create_or_update(attrs)
    find_or_create_by(id: attrs[:sku_unique_id])
      .update_attributes(attrs.reject { |k, _v| k == :sku_unique_id })
  end
end
