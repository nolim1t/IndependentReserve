# IndependentReserve
Ruby library for interfacing with the IndependentReserve API (https://www.independentreserve.com/Api)

## Installing
* gem install httparty
* gem install nl-independentreserve

## Environment Variables
* ir_access_key
* ir_access_secret

## Usage Examples:
### Example 1
```ruby
require "nl-independentreserve"
i = IndependentReserve.new
puts i.private_GetOpenOrders({:pageIndex => 1, :pageSize => 50})
```

### Example 2
```ruby
require "nl-independentreserve"
i = IndependentReserve.new({:primaryCurrency => "XBT", :secondaryCurrency => "USD"})
puts i.private_GetOpenOrders({:pageIndex => 1, :pageSize => 50})
puts i.public_GetOrderBook
```

### Example 3 Get open order book
```ruby
require "nl-independentreserve"
i = IndependentReserve.new
puts i.public_GetOrderBook
```

### Shell commands
```bash
ruby -e 'require "nl-independentreserve"; i = IndependentReserve.new({:primaryCurrency => "XBT", :secondaryCurrency => "USD"}); puts i.private_GetOpenOrders({:pageIndex => 1, :pageSize => 50}); '

ruby -e 'require "nl-independentreserve"; i = IndependentReserve.new({:primaryCurrency => "XBT", :secondaryCurrency => "USD"}); puts i.public_GetOrderBook; '
```
