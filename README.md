# Tea Subscription, README
This project is part of Mod 4 intermission work take home test for [Turing School of Software and Design Backend](https://backend.turing.edu/module3/projects/sweater_weather/requirements), where we were asked to build an endpoints for following backend api:
  - An endpoint to subscribe a customer to a tea subscription
  - An endpoint to cancel a customer’s tea subscription
  - An endpoint to see all of a customer’s subscriptions (active and cancelled)
The goal of this test is to provide an api that is easy to use by the end user.

The api was built using the following relationships between customers, teas, and subscriptions. The customer can have many subscriptions and tea can have many subscriptions. A subscription belongs to tea and customer. This decision was made to allow customers 'customize' their tea subscription per tea.
 
![Schema](<Screenshot 2024-01-27 at 8.31.03 PM.png>)

# Built With (and Gems)
- Ruby on Rails
- Pry
- Simplecov
- Rspec-rails
- Capybara
- Launchy
- JSONAPI-serializer


# Getting Started
If you want to checkout the end points using postman, please clone and/or fork this project and follow these steps:

##### Set up:
  - run `bundle`
  - `rails db:{create,migrate}`
  - Connect to `rails s`
  - Open postman, input endpoints and appropriate request

##### Endpoints:
  - post '/api/v1/subscriptions
  - patch "/api/v1/subscriptions/subscription.id
  - get '/api/v1/subscriptions'

 *example* <br>
  
  To subscribe a customer (existing) for tea (existing), 
  ```json
  POST http://localhost:3000/api/v1/subscriptions
  Content-Type: application/json
  Accept: application/json

  {
    "title": "Green Tea 1 per week", 
    "price": "$ 10",
    "frequency": "1 per week",
    "status": 1,
    "tea_id": 1,
    "customer_id": 1
  }
  ```

  expected result
  status: 201

  ```json
  {
      "data": {
          "id": "1",
          "type": "subscriptions",
          "attributes": {
              "title": "Green Tea 1 per week",
              "price": "$ 10",
              "status": "active",
              "frequency": "1 per week",
              "customer_id": 1,
              "tea_id": 1
          }
      }
  }
  ```