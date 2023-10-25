# Heroswap contracts

A guildline for deploying Heroswap contracts on BSC.

## Manual Installation

If you would still prefer to do the installation manually, follow these steps:

Install the dependencies:

```bash
yarn install
```

Set the environment variables:

```bash
cp .env.example .env

# open .env and modify the environment variables
```

## Commands

### Step 1: Deploying the Factory contract

#### Compile all solidity files:

```bash
npx hardhat compile
```

Modify the `scripts/deploy.js` file to set the correct parameters for the deployment.

#### Deploy the Factory contract:

```bash
npx hardhat run --network testnet scripts/deploy.js
```

#### Verify the Factory contract on BSCScan:

```bash
npx hardhat verify --network testnet <contract-address> <feeToSetter>
```

### Step 2: Deploying the Router contract
