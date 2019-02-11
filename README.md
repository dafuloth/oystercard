# oystercard

Week 2 Pairing Exercise.

From: https://github.com/makersacademy/course/tree/master/oystercard  
Diode: https://diode.makersacademy.com/students/soph-g/projects/3276


### 4. Adding a balance

```
In order to use public transport  
As a customer  
I want money on my card  
```
Plan for checking a new card is initialised with a balance of 0: 

```pry
[1] pry(main)> new_card = Oystercard.new
NameError: uninitialized constant Oystercard
from (pry):1:in `__pry__'

[2] pry(main)> new_card.balance == 0
NoMethodError: undefined method `balance' for nil:NilClass
from (pry):2:in `__pry__'

```

Unit test:

```ruby
describe Oystercard do
  it 'has a balance of 0 when newly initialized' do
    card = Oystercard.new
    expect(card.balance).to eq 0
  end
end
```
