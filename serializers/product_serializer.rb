class ProductSerializer
  def initialize(product)
    @product = product
  end

  def as_json(*)
    data = {
        id: @product.id.to_s,
        product_name: @product.product_name,
        photo_url: @product.photo_url,
        barcode: @product.barcode,
        price_cents: @product.price_cents,
        producer: @product.producer
    }
    data[:errors] = @product.errors if @product.errors.any?
    data
  end
end

