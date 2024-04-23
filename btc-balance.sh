#!/bin/bash
# Function to display usage information
usage() {
    echo "Usage: $0 [--address <Bitcoin address>]"
    echo "       $0 (reads from Address.txt by default)"
    exit 1
}
 
# Function to fetch and display balance for multiple addresses
fetch_balances() {
    local addresses=$1
    # Query the Blockchain.info multiaddr API
    local response=$(curl -s "https://blockchain.info/multiaddr?active=$addresses")
    # Check if the response is empty
    if [ -z "$response" ]; then
        echo "Error: No response from API."
        exit 1
    fi
    # Query for the current BTC to USD exchange rate
    local btc_to_usd_rate=$(curl -s "https://blockchain.info/ticker" | jq -r ".USD.last")
    # Loop through each address in the response
    echo $response | jq -c '.addresses[]' | while read -r addr; do
        local address=$(echo $addr | jq -r ".address")
        local final_balance=$(echo $addr | jq -r ".final_balance")
        # Convert the final balance from satoshi to BTC (1 BTC = 100,000,000 satoshi)
        local final_balance_btc=$(bc <<< "scale=8; $final_balance / 100000000")
        local final_balance_btc_in_usd=$(bc <<< "scale=2; $final_balance_btc * $btc_to_usd_rate")
        printf -v formatted_btc_in_usd "%.2f" $final_balance_btc_in_usd
        # Output the final balance in BTC
        echo "Balance for $address: $final_balance_btc BTC (~$formatted_btc_in_usd USD)"
    done
}
 
# Main script
if [[ "$#" -eq 0 ]]; then
    # Read from Address.txt if no arguments are provided
    if [ ! -f Address.txt ]; then
        echo "Error: Address.txt not found."
        exit 1
    fi
    addresses=$(tr '\n' '|' < Address.txt | sed 's/|$//')
    fetch_balances "$addresses"
else
    # Parse command line arguments
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            --address) addresses="$2"; shift ;;
            *) echo "Unknown parameter passed: $1"; usage; exit 1 ;;
        esac
        shift
    done
    # Check if the address is provided
    if [ -z "$addresses" ]; then
        echo "Error: Address not provided."
        usage
    fi
    fetch_balances "$addresses"
fi