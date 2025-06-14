require_relative '../lib/basket'
require 'minitest/autorun'

class BasketTest < Minitest::Test
  def setup
    # Product catalog
    @products = [
      { code: 'R01', name: 'Red Widget', price: 32.95 },
      { code: 'G01', name: 'Green Widget', price: 24.95 },
      { code: 'B01', name: 'Blue Widget', price: 7.95 }
    ]
    
    # Delivery charge rules
    @delivery_rules = [
      { threshold: 90, charge: 0 },      # Orders $90 or more: free delivery
      { threshold: 50, charge: 2.95 },   # Orders $50-$89.99: $2.95 delivery
      { threshold: 0, charge: 4.95 }     # Orders under $50: $4.95 delivery
    ]
    
    # Offers
    @offers = [:red_widget_half_price]  # "buy one red widget, get the second half price"
  end
  
  def test_basket_example_one
    # B01, G01 = $37.85
    basket = Basket.new(@products, @delivery_rules, @offers)
    basket.add('B01')
    basket.add('G01')
    assert_equal 37.85, basket.total
  end
  
  def test_basket_example_two
    # R01, R01 = $54.37
    basket = Basket.new(@products, @delivery_rules, @offers)
    basket.add('R01')
    basket.add('R01')
    assert_equal 54.37, basket.total
  end
  
  def test_basket_example_three
    # R01, G01 = $60.85
    basket = Basket.new(@products, @delivery_rules, @offers)
    basket.add('R01')
    basket.add('G01')
    assert_equal 60.85, basket.total
  end
  
  def test_basket_example_four
    # B01, B01, R01, R01, R01 = $98.27
    basket = Basket.new(@products, @delivery_rules, @offers)
    basket.add('B01')
    basket.add('B01')
    basket.add('R01')
    basket.add('R01')
    basket.add('R01')
    assert_equal 98.27, basket.total
  end
end
