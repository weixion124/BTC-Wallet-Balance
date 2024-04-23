# BTC Balance Check

## Setup environment
Install needed dependencies
```
sudo apt-get update
sudo apt-get install jq bc
```

Give the script execution permissions:
```
sudo chmod +x btc-balance.sh
```

## Query balance by wallet address
```
./btc-balance.sh --address <bitcoin-wallet-address>
```

Usage example
```
./btc-balance.sh --address 1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa
Balance for 1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa: 99.75890359 BTC (~6588998.77 USD)
```

## Query balance by file
No option is needed, the wallet addresses to query are stored in Address.txt\
To query you wallet address list, please **edit the Address.txt, one address per line, no blank line**.
```
./btc-balance.sh
```
Usage example
```
./btc-balance.sh
Balance for 12cbQLTFMXRnSzktFkuoG3eHoMeFtpTu3S: 18.44160772 BTC (~1217415.17 USD)
Balance for 1NKL2xSe419gHzieZ8gvtAxNKwAjA4jxjU: .02029600 BTC (~1339.83 USD)
Balance for 1A1zP1eP5QGefi2DMPTfTL5SLmv7DivfNa: 99.75890359 BTC (~6585543.12 USD)
```