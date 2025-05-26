# Rewards Contract
A Cairo smart contract for managing reward points on Starknet. This contract allows users to add, redeem, and transfer reward points in a decentralized manner.

# Deployment Information
## Starknet Sepolia Testnet
The contract has been successfully deployed on Starknet Sepolia testnet:

## My new account created:
comand used to create my new account: sncast account create --name my_sepolia_account --network sepolia --add-profile
new account created: 0x07a3ea104393311489472d22f1f9967e1d93961e3a86fd539155adb110f77f06

## Command to deploy
sncast account deploy --network sepolia --name my_sepolia_account

Transaction hash: 0x060eec22a0f08329ffa6856bf6cce081f5d211bf0a79bafdc00403a62a4199a2
Contract Address: 0x07a3ea104393311489472d22f1f9967e1d93961e3a86fd539155adb110f77f06

## View on sepolia: https://sepolia.starkscan.co/tx/0x060eec22a0f08329ffa6856bf6cce081f5d211bf0a79bafdc00403a62a4199a2

# Overview
The Rewards Contract is a Cairo smart contract built for Starknet that implements a points-based reward system. Users can accumulate points, redeem them for rewards, and transfer points to other addresses. The contract maintains individual balance tracking for each address and emits events for important state changes.

# Command to check balance
## Check balance for a specific address
sncast --profile sepolia call \
  --contract-address 0x07a3ea104393311489472d22f1f9967e1d93961e3a86fd539155adb110f77f06 \
  --function "getPoints" \
  --calldata 0x1234567890abcdef1234567890abcdef12345678

  # Redeem 500 points
sncast --profile sepolia call \
  --contract-address 0x0012e34871bf8a37d72ad81907cd0e04e886656a98b14b9c4eed00bdcbf5a00b \
  --function "redeemPoints" \
  --calldata 500

  # Transfer 250 points to another address
sncast --profile sepolia call \
  --contract-address 0x0012e34871bf8a37d72ad81907cd0e04e886656a98b14b9c4eed00bdcbf5a00b \
  --function "transferPoints" \
  --calldata 0x0987654321fedcba0987654321fedcba09876543 250