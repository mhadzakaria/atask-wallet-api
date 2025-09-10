# Wallet API

This is a Rails API that provides wallet management and stock price information(from https://latest-stock-price.p.rapidapi.com).

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
3.  Run seeds file:
    ```bash
    rails db:seeds
    ```

## How to run the application

```bash
rails s
```

## API Endpoints

### API Endpoints

All API endpoints are prefixed with `/api/v1`.

#### Session

*   `POST /api/v1/sign_in`: Sign in a user.
    *   **Parameters**: `email`, `password`
    *   **CURL**
        ```bash
            curl --request POST \
              --url http://localhost:3000/api/v1/sign_in \
              --header 'content-type: multipart/form-data' \
              --form email=azak808@gmail.com \
              --form password=password
        ```
    *   **Example Response**
        ```json
            {
                "access_token": "d3e815adae0b76e759f0ddfa4525e6897c08dee7"
            }
        ```

*   `DELETE /api/v1/sign_out`: Sign out a user.
    *   **Headers**:
        * `Authorization`: Filled from response Sign In endpoint > access_token
    *   **CURL**
        ```bash
            curl --request DELETE \
              --url http://localhost:3000/api/v1/sign_out \
              --header 'Authorization: d3e815adae0b76e759f0ddfa4525e6897c08dee7'
        ```
    *   **Example Response**
        ```json
            {
                  "message": "Signed out"
            }
        ```

#### Stock Prices

*   `GET /api/v1/price?symbol=AAPL`: Get the price of a single stock. (Deprecated: Data sourced from https://latest-stock-price.p.rapidapi.com)
    * Last response:
        ```json
            {
                "message": "Endpoint '/price' does not exist"
            }
        ```
*   `GET /api/v1/prices?symbols=AAPL,GOOG`: Get the prices of multiple stocks. (Deprecated: Data sourced from https://latest-stock-price.p.rapidapi.com)
    * Last response:
        ```json
            {
                "message": "Endpoint '/prices' does not exist"
            }
        ```
*   `GET /api/v1/price_all`: Get the prices of all available stocks. (Deprecated: Data sourced from https://latest-stock-price.p.rapidapi.com)
    * Last response:
        ```json
            {
                "message": "Endpoint '/price_all' does not exist"
            }
        ```

#### Wallet Transactions

*   `POST /api/v1/deposit`: Create a deposit transaction.
    *   **Parameters**:
        *   `target_type`: Type of the target wallet owner (e.g., `User`, `Team`, `Stock`).
        *   `target_id`: ID of the target wallet owner.
        *   `amount`: The amount to deposit.
    *   **CURL**
        ```bash
            curl --request POST \
              --url http://localhost:3000/api/v1/deposit \
              --header 'content-type: multipart/form-data' \
              --form target_type=User \
              --form target_id=1 \
              --form amount=1000
        ```

*   `POST /api/v1/withdraw`: Create a withdraw transaction.
    *   **Parameters**:
        *   `source_type`: Type of the source wallet owner (e.g., `User`, `Team`, `Stock`).
        *   `source_id`: ID of the source wallet owner.
        *   `amount`: The amount to withdraw.
    *   **CURL**
        ```bash
            curl --request POST \
              --url http://localhost:3000/api/v1/withdraw \
              --header 'content-type: multipart/form-data' \
              --form source_type=User \
              --form source_id=1 \
              --form amount=500
        ```

*   `POST /api/v1/transfer`: Create a transfer transaction.
    *   **Parameters**:
        *   `source_type`: Type of the source wallet owner (e.g., `User`, `Team`, `Stock`).
        *   `source_id`: ID of the source wallet owner.
        *   `target_type`: Type of the target wallet owner (e.g., `User`, `Team`, `Stock`).
        *   `target_id`: ID of the target wallet owner.
        *   `amount`: The amount to transfer.
    *   **CURL**
        ```bash
            curl --request POST \
              --url http://localhost:3000/api/v1/transfer \
              --header 'content-type: multipart/form-data' \
              --form source_type=User \
              --form source_id=1 \
              --form target_type=Team \
              --form target_id=1 \
              --form amount=250
        ```
