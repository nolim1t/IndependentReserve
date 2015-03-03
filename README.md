# IndependentReserve
Ruby library for interfacing with the IndependentReserve API (https://www.independentreserve.com/Api)

## TODO
* Make this comply to a gemspec

## Usage Examples:

```bash
ruby -e 'require "./IndependentReserve.rb"; i = IndependentReserve.new({:primaryCurrency => "XBT", :secondaryCurrency => "USD"}); puts i.private_GetOpenOrders({:pageIndex => 1, :pageSize => 50}); '

ruby -e 'require "./IndependentReserve.rb"; i = IndependentReserve.new({:primaryCurrency => "XBT", :secondaryCurrency => "USD"}); puts i.public_GetOrderBook; '
```

