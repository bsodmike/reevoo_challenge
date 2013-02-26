class Product
  def initialize(products = {})
    @products = products
  end

  def all
    @products
  end

  def find(item_code)
    @products[item_code.to_sym]
  end

  def add_item(item)
    @products = @products.merge(item)
  end
end
