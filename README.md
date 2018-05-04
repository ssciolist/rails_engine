# Rails Engine

Rails Engine is an API built with Ruby on Rails to serve JSON data about an online store platform. Using this API, you can find information about merchants, their items, their customers and more. Rails Engine also serves performance analytics like top merchants and their best days.

Check out the API reference index to see everything you can do.

## Setup

Once you've forked or cloned this repository to your computer, run `bundle install` to get the proper dependencies installed.

Then, create your database:

`rails db:create`

`rails db:migrate`

Next, import your data:

`rake import:all`

Now you should be able to run `rails s` to start a server and query the API. Most server instances will be accessible at http://localhost:3000/.

## Running the tests

Use `bundle exec rspec` from the terminal to run all tests.

## API reference index

This API is built to deliver information about merchants, items, invoices, invoice items, customers, and transactions.

### Basic information

Category endpoints are the backbone of this application and many subsequent endpoints build from them. Use a category endpoint to request all records for a given category using the following convention:

```
GET /api/v1/merchants
```

```
GET /api/v1/items
```

```
GET /api/v1/invoices
```

```
GET /api/v1/invoice_items
```

```
GET /api/v1/customers
```

```
GET /api/v1/transactions
```
To request a specific record, like a certain merchant, add the record id to the category endpoint. For example:

```
GET /api/v1/merchants/1
```
This convention can be used for all record types, building off the category endpoint.

###### How to search

If you don't know the id of the record you want, that's ok. You can also use the search function.

To find one record, start from your category endpoint, append 'find', and query the attribute you're searching and your search term. For example:

```
GET /api/v1/merchants/find?name=Jane
```

To find all matching records:

```
GET /api/v1/merchants/find_all?name=Jane
```

Here's all the attributes you can query, organized by model. Date attributes (created_at and updated_at) should be formatted as formatted as yyyy-mm-dd

| Model        | Attributes           |
| ------------- |:-------------:|
| Merchants      | name, created_at, updated_at |
| Items     | name, description, unit_price, merchant_id, created_at, updated_at |
| Invoices      | customer_id, merchant_id, status, created_at, updated_at  |
| Invoice Items      | item_id, invoice_id, quantity, unit_price, created_at, updated_at |
| Transactions      | invoice_id, credit_card_number, result, created_at, updated_at |
| Customers      | first_name, last_name, created_at, updated_at |
*** Dates should be formatted as formatted as yyyy-mm-dd**

###### Random

Get a random record using the following structure:

```
GET /api/v1/CATEGORY_ENDPOINT/random
```

For example, to get a random merchant:

```
GET /api/v1/merchants/random
```

### Relationships

To find more information about a single record's related data, you can query a relationship endpoint. The following relation endpoints are available:

###### Merchant relations
```
GET /api/v1/merchants/:id/items
```
```
GET /api/v1/merchants/:id/invoices
```
###### Item relations
```
GET /api/v1/items/:id/invoice_items
```
```
GET /api/v1/items/:id/merchant
```
###### Invoice relations
```
GET /api/v1/invoices/:id/transactions
```
```
GET /api/v1/invoices/:id/invoice_items
```
```
GET /api/v1/invoices/:id/items
```
```
GET /api/v1/invoices/:id/customer
```
```
GET /api/v1/invoices/:id/merchant
```
###### Transaction relations
```
GET /api/v1/transactions/:id/invoice
```
###### Customer relations
```
GET /api/v1/customers/:id/invoices
```
```
GET /api/v1/customers/:id/transactions
```
###### Invoice Item relations
```
GET /api/v1/invoice_items/:id/invoice
```
```
GET /api/v1/invoice_items/:id/item
```

### Analytics

The following business intelligence endpoints are available:

###### All Merchants
```
GET /api/v1/merchants/most_revenue?quantity=x
```
* returns the top x merchants ranked by total revenue

```
GET /api/v1/merchants/most_items?quantity=x
```
* returns the top x merchants ranked by total number of items sold

```
GET /api/v1/merchants/revenue?date=x
 ```
* returns the total revenue for date x across all merchants

###### Single Merchant
```
GET /api/v1/merchants/:id/revenue
```
* returns the total revenue for that merchant across successful transactions

```
GET /api/v1/merchants/:id/revenue?date=x
```
* returns the total revenue for that merchant for a specific invoice date x

```
GET /api/v1/merchants/:id/favorite_customer
```
* returns the customer who has conducted the most total number of successful transactions.

###### Items
```
GET /api/v1/items/most_revenue?quantity=x
```
* returns the top x items ranked by total revenue generated
```
GET /api/v1/items/most_items?quantity=x
```
* returns the top x item instances ranked by total number sold

```
GET /api/v1/items/:id/best_day
```
* returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, it returns the most recent day.

###### Customers
```
GET /api/v1/customers/:id/favorite_merchant
```
* returns a merchant where the customer has conducted the most successful transactions

## Versions

* Ruby version 2.4.1
* Rails version 5.6.1
* Rspec version 3.7.1
