In order to use public transport
As a customer
I want money on my card

In order to keep using public transport
As a customer
I want to add money to my card

In order to protect my money
As a customer
I don't want to put too much money on my card

In order to pay for my journey
As a customer
I need my fare deducted from my card

In order to get through the barriers
As a customer
I need to touch in and out

In order to pay for my journey
As a customer
I need to have the minimum amount for a single journey

In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

In order to pay for my journey
As a customer
I need to know where I've travelled from

In order to know where I have been
As a customer
I want to see to all my previous trips

In order to know how far I have travelled
As a customer
I want to know what zone a station is in

In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out

In order to be charged the correct amount
As a customer
I need to have the correct fare calculated




| Object  | Methods    |
|---------|------------|
| card    | balance    |
|         |   top up   |
|         |   limit    |
|         |    charge  |
|         |  touch_in  |
|         |  touch_out |
|         |  check_min |
|         |  complete  |
|         |  history   |
|         |  penalty   |



`Update your test suite to reflect a new Journey class`
Create a new class Journey and move the functionality that relates to a journey from Oystercard to Journey
Make sure all tests pass, all existing functionality is preserved
The #fare method should return the minimum fare (for the moment), or the penalty fare of 6 if there was either no entry station or no exit station.
Make sure the entire codebase is DRY
Make sure all methods are three lines or shorter
