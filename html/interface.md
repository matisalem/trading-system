## API

### Trades
- `PUT /bookTrade`: Books a trade
- `POST /csv_to_json`: Converts a CSV file into a list of trades
- `POST /bookManyTrades`: Books a list of trades
- `POST /updateTrade`: Updates a previously booked trade
- `GET /queryTrades`: Queries trades by date and account
- `GET /getTradeHistory`: Gets the full edit history of a trade
- `GET /getAccounts`: Gets a list of all accounts that booked trades
- `GET /tickers`: Gets a list of all valid tickers

### Positions
- `GET /positions`: Gets a list of all positions
- `GET /positions/{account}`: Gets a list of all positions for a specific account
- `GET /positions/{account}/{ticker}`: Gets a position given an account and ticker pair

### PNL
- `GET /pl/profitLoss`: Gets the profit/loss for a specific accont and ticker pair
- `GET /pl/allProfitLoss`: Gets a list of all profits/losses for an account

## WebSocket

The websocket endpoint is: `/ws/{datatype}?accounts={accounts}`
where `{datatype}` is the data type that is being watched, and `{accounts}` is a comma seperated list of accounts

The general message format is:
```json
{
    "type": "{type}",
    "payload": {
        // the schema for the given data type
    }
}
```

### /trades
Types:
- create (a new trade was booked)
- update (a previously booked trade was updated)

Schema: Trade

### /positions
Types:
- position (default)

Schema: Position

## Schemas

### Trade
- id (string): a unique identifier for the trade (generated by system)
- account (string): the account which booked the trade (given by user)
- type (string): `buy` or `sell` (given by user)
- stock_ticker (string): the stock which the trade was for (given by user)
- amount (int): the amount of shares the trade was for (given by user)
- date (date): the date the trade was booked (generated by system)
- time (time): the time the trade was booked (generated by system)
- user (string): the user who booked the trade (given by user)
- price (float): the unit price the stock was bought or sold at (given by user)
- version (int): the version number in the case of an edit (generated by system)

### Position
- account (string)
- stock_ticker (string)
- amount (int): how many shares long (positive) or short (negative) the position is
- last_aggregation_time (datetime)
- last_aggregation_host (string)

### Price
- stock_ticker (string)
- price (double)
- is_closing_price (boolean) whether this is an end of day price

### History
- trades (list of trades): all previous versions
- current_version (int): the index of the current version

### ProfitLoss
- trade_pl (float)
- position_pl (float)