# oystercard

Week 2 Pairing Exercise.

From: https://github.com/makersacademy/course/tree/master/oystercard  
Diode: https://diode.makersacademy.com/students/soph-g/projects/3276


## Feature Tests

### Checking a new card is initialised with a balance of 0:

In order to use public transport  
As a customer  
I want money on my card  

``` ruby
card = Oystercard.new
card.balance == 0

```

### Topping up

In order to keep using public transport  
As a customer  
I want to add money to my card  

```ruby
card = Oystercard.new
card.top_up(90)
card.balance

```

### Card has a balance limit 

In order to protect my money  
As a customer  
I don't want to put too much money on my card  

```ruby
card = Oystercard.new
card.top_up(900)

=> Expect raise error 'Over limit'

```

### Deduct a fare amount from card to pay for a journey
In order to pay for my journey  
As a customer  
I need my fare deducted from my card  

```ruby
card = Oystercard.new
card.top_up(90)
card.deduct(40)
card.balance

=> Expect to see balance of 50

```

### Touch-in and touch-out with the card to get through barriers
In order to get through the barriers  
As a customer  
I need to touch in and out  

```ruby 
card = Oystercard.new
card.top_up(50)

card.in_journey?
=> false

card.touch_in

card.in_journey?
=> true

card.touch_out

card.in_journey?
=> false

```

### Card should have a balance to be able to make a journey
In order to pay for my journey  
As a customer  
I need to have the minimum amount for a single journey  

```ruby
card = Oystercard.new
card.touch_in

=> Expect an error of 'Insufficient funds'
```


### When journey is complete, balance is reduced by the fare amount

In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

_assume that a journey costs £1:_

```ruby
card = Oystercard.new
card.top_up(90)
# card.touch_in
card.touch_out
card.balance
=> 89

# Note that the code currently allows touch_out without first touch_in, may need to revise previous test

```
### Starting station is recorded

In order to pay for my journey  
As a customer  
I need to know where I've travelled from  

_for the example, let's say starting station is "Aldgate"_

```ruby
card = Oystercard.new
card.top_up(90)

card.touch_in("Aldgate")
card.entry_station

=> "Aldgate"

```


### Can see journey history

In order to know where I have been  
As a customer  
I want to see to all my previous trips  

```ruby
card = Oystercard.new
card.top_up(90)

card.touch_in("Aldgate")
card.touch_out("Westminster")

card.history
=> [{:entry_station=>"Aldgate", :exit_station=>"Westminster"}]

```


### Can see what zone a station is in

In order to know how far I have travelled  
As a customer  
I want to know what zone a station is in  

```ruby
station = Station.new("Aldgate", 1)

station.name
=> "Aldgate"

station.zone
=> 1

```





In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out

In order to be charged the correct amount
As a customer
I need to have the correct fare calculated
