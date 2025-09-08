# Wallet API

This is a Rails API that provides wallet management and stock price information.

## Ruby Version

*   ruby 3.0.3

## System Dependencies

*   Bundler

## Configuration

1.  Install dependencies:
    ```bash
    bundle install
    ```
2.  Create a `.env` file in the root of the project and add your RapidAPI key:
    ```
    RAPIDAPI_KEY=your_rapidapi_key
    ```

## Database Setup

1.  Create the database:
    ```bash
    rails db:create
    ```
2.  Run the migrations:
    ```bash
    rails db:migrate
    ```

## How to run the application

```bash
rails s
```

## API Endpoints

### Session

*   `POST /sessions`: Sign in a user.
    *   **Parameters**: `name`
*   `DELETE /sessions`: Sign out a user.

### Stock Prices

*   `GET /price?symbol=AAPL`: Get the price of a single stock.
*   `GET /prices?symbols=AAPL,GOOG`: Get the prices of multiple stocks.
*   `GET /price_all`: Get the prices of all available stocks.