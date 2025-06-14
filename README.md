# Acme Widget Co - Basket System

This is a proof of concept implementation of Acme Widget Co's new sales system. The system implements a basket functionality with product management, delivery cost rules, and special offers.

## Features

- Product catalog management
- Configurable delivery charge rules based on order subtotal
- Special offer: "buy one red widget, get the second half price"
- Simple API with `add` and `total` methods

## Usage

```ruby
require_relative 'lib/basket'

# Define your product catalog
products = [
  { code: 'R01', name: 'Red Widget', price: 32.95 },
  { code: 'G01', name: 'Green Widget', price: 24.95 },
  { code: 'B01', name: 'Blue Widget', price: 7.95 }
]

# Define delivery charge rules
delivery_rules = [
  { threshold: 90, charge: 0 },      # Orders $90 or more: free delivery
  { threshold: 50, charge: 2.95 },   # Orders $50-$89.99: $2.95 delivery
  { threshold: 0, charge: 4.95 }     # Orders under $50: $4.95 delivery
]

# Define special offers
offers = [:red_widget_half_price]

# Create a new basket
basket = Basket.new(products, delivery_rules, offers)

# Add items to the basket
basket.add('R01')  # Red Widget
basket.add('G01')  # Green Widget

# Calculate the total price
total = basket.total  # Returns 60.85
```

## Testing

Tests are written using Minitest and can be run with:

```
ruby test/basket_test.rb
```

The test cases verify the basket functionality against the provided example scenarios.

## Design Decisions & Assumptions

1. **Data Structures**: 
   - Products are represented as hashes with code, name, and price keys
   - Delivery rules are defined as threshold/charge pairs and sorted by threshold
   - Offers are represented as symbols for simplicity

2. **Offer Implementation**:
   - Currently implements the "buy one red widget, get the second half price" offer
   - The system can be extended to handle more complex offers by adding rules to the `apply_offers` method

3. **Rounding**:
   - All totals are rounded to 2 decimal places, as is common for currency values

4. **Error Handling**:
   - The implementation assumes valid product codes are provided
   - In a production environment, validation and error handling would be added

## Future Enhancements

- Add validation for product codes
- Implement a more flexible offer system with rules that can be composed
- Add inventory management functionality
