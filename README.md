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

## Core Concepts

This API is designed with a strong emphasis on data consistency and atomicity, especially for financial transactions. The `TransactionCreator` service object plays a central role in ensuring that all transaction-related operations (creating a transaction record and updating associated wallet balances) occur within a single, atomic database transaction. This guarantees that either all parts of a transaction succeed, or none do, preventing inconsistent states and upholding ACID properties.


## API Endpoints

### Session

*   `POST /sessions`: Sign in a user.
    *   **Parameters**: `name`
*   `DELETE /sessions`: Sign out a user.

### Stock Prices

*   `GET /price?symbol=AAPL`: Get the price of a single stock.
*   `GET /prices?symbols=AAPL,GOOG`: Get the prices of multiple stocks.
*   `GET /price_all`: Get the prices of all available stocks.

### Wallet Transactions

*   `POST /transactions/deposit`: Create a deposit transaction.
    *   **Parameters**:
        *   `target_type`: Type of the target wallet owner (e.g., `User`, `Team`, `Stock`).
        *   `target_id`: ID of the target wallet owner.
        *   `amount`: The amount to deposit.

*   `POST /transactions/withdraw`: Create a withdraw transaction.
    *   **Parameters**:
        *   `source_type`: Type of the source wallet owner (e.g., `User`, `Team`, `Stock`).
        *   `source_id`: ID of the source wallet owner.
        *   `amount`: The amount to withdraw.

*   `POST /transactions/transfer`: Create a transfer transaction.
    *   **Parameters**:
        *   `source_type`: Type of the source wallet owner (e.g., `User`, `Team`, `Stock`).
        *   `source_id`: ID of the source wallet owner.
        *   `target_type`: Type of the target wallet owner (e.g., `User`, `Team`, `Stock`).
        *   `target_id`: ID of the target wallet owner.
        *   `amount`: The amount to transfer.
