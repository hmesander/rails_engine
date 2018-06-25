## Rails Engine

* JSON API Exploration
This project uses Ruby on Rails, ActiveRecord and a PostgreSQL database to build JSON API endpoints that expose typical [eCommerce data] (https://github.com/turingschool-examples/sales_engine/tree/master/data). This API serves business intelligence, relationship endpoints, and record endpoints.

* The spec for this project can be found here: [Project Spec](http://backend.turing.io/module3/projects/rails_engine)

### Getting Started

To run this application locally, clone this repo and follow the steps below:

Bundle:
`$ bundle`

Seed the database:
`$ rake db:{create,migrate}`
`$ rake import_all`

Start up your rails server with `rails s`
and open localhost:3000 in your browser.

### System Requirements

Ruby Version: 2.4+
Rails Version: 5+

### Running the tests

To run the test suite, run `rspec` from the root directory in your terminal.

### Endpoints

#### Record Endpoints

GET /api/v1/merchants/

GET /api/v1/merchants/:id


GET /api/v1/invoices/

GET /api/v1/invoices/:id

GET /api/v1/invoice_items/

GET /api/v1/invoice_items/:id

GET /api/v1/items/

GET /api/v1/items/:id

GET /api/v1/transactions/

GET /api/v1/transactions/:id

GET /api/v1/customers/

GET /api/v1/customers/:id

GET /api/v1/(resource)/find?parameters (example: GET /api/v1/merchants/find?name=Schroeder-Jerde)

GET /api/v1/(resource)/find_all?parameters (example: GET /api/v1/merchants/find_all?name=Cummings-Thiel)

GET api/v1/(resource)/random.json(example: GET api/v1/merchants/random.json) - returns a random resource



#### Relationship Endpoints

##### Merchants

GET /api/v1/merchants/:id/items returns a collection of items associated with that merchant

GET /api/v1/merchants/:id/invoices returns a collection of invoices associated with that merchant from their known orders

##### Invoices


GET /api/v1/invoices/:id/transactions returns a collection of associated transactions

GET /api/v1/invoices/:id/invoice_items returns a collection of associated invoice items

GET /api/v1/invoices/:id/items returns a collection of associated items

GET /api/v1/invoices/:id/customer returns the associated customer

GET /api/v1/invoices/:id/merchant returns the associated merchant

##### Invoice Items

GET /api/v1/invoice_items/:id/invoice returns the associated invoice

GET /api/v1/invoice_items/:id/item returns the associated item

##### Items

GET /api/v1/items/:id/invoice_items returns a collection of associated invoice items

GET /api/v1/items/:id/merchant returns the associated merchant

##### Transactions

GET /api/v1/transactions/:id/invoice returns the associated invoice

##### Customers

GET /api/v1/customers/:id/invoices returns a collection of associated invoices

GET /api/v1/customers/:id/transactions returns a collection of associated transactions

#### Business Intelligence Endpoints

##### All Merchants

GET /api/v1/merchants/most_revenue?quantity=x returns the top x merchants ranked by total revenue

GET /api/v1/merchants/most_items?quantity=x returns the top x merchants ranked by total number of items sold

GET /api/v1/merchants/revenue?date=x returns the total revenue for date x across all merchants. Assume the dates provided match the format of a standard ActiveRecord timestamp.

##### Single Merchant

GET /api/v1/merchants/:id/revenue returns the total revenue for that merchant across successful transactions

GET /api/v1/merchants/:id/revenue?date=x returns the total revenue for that merchant for a specific invoice date x

GET /api/v1/merchants/:id/favorite_customer returns the customer who has conducted the most total number of successful transactions.

GET /api/v1/merchants/:id/customers_with_pending_invoices returns a collection of customers which have pending (unpaid) invoices. A pending invoice has no transactions with a result of success.

##### Items

GET /api/v1/items/most_revenue?quantity=x returns the top x items ranked by total revenue generated

GET /api/v1/items/most_items?quantity=x returns the top x item instances ranked by total number sold

GET /api/v1/items/:id/best_day returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, return the most recent day.

##### Customers

GET /api/v1/customers/:id/favorite_merchant returns a merchant where the customer has conducted the most successful transactions


## Built With

* [factorybot](https://github.com/thoughtbot/factory_bot)
* [database cleaner](https://github.com/DatabaseCleaner/database_cleaner)
* [shoulda matchers](https://github.com/thoughtbot/shoulda-matchers)

## Authors
[Zachary Thomas] (https://github.com/zdcthomas)
* [Haley Mesander](https://github.com/hmesander)
