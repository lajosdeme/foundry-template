# Foundry Template [![Open in Gitpod][gitpod-badge]][gitpod] [![Github Actions][gha-badge]][gha] [![Foundry][foundry-badge]][foundry] [![License: MIT][license-badge]][license]

[gitpod]: https://gitpod.io/#https://github.com/lajopsdeme/foundry-template
[gitpod-badge]: https://img.shields.io/badge/Gitpod-Open%20in%20Gitpod-FFB45B?logo=gitpod
[gha]: https://github.com/lajosdeme/foundry-template/actions
[gha-badge]: https://github.com/lajosdeme/foundry-template/actions/workflows/test.yml/badge.svg
[foundry]: https://getfoundry.sh/
[foundry-badge]: https://img.shields.io/badge/Built%20with-Foundry-FFDB1C.svg
[license]: https://opensource.org/licenses/MIT
[license-badge]: https://img.shields.io/badge/License-MIT-blue.svg

My custom Foundry template that I use for all of my Solidity smart contract development projects.

## Libraries
### Solidity:
- [Forge](https://github.com/foundry-rs/foundry/blob/master/forge): compile, test, fuzz, format, and deploy smart
  contracts
- [Forge Std](https://github.com/foundry-rs/forge-std): collection of helpful contracts and utilities for testing
- [Open Zeppelin](https://github.com/openzeppelin/openzeppelin-contracts): OpenZeppelin contracts library

### Optional:
If you want to be able to run `make audit` you have to install Slither and Aderyn.
- [Slither](https://github.com/crytic/slither): Static analyzer for Solidity and Vyper
- [Aderyn](https://github.com/Cyfrin/aderyn): Aderyn 🦜 Rust-based Solidity AST analyzer.

## Getting started:
The easiest way to get started is to click the [`Use this template`](https://github.com/lajosdeme/foundry-template/generate) button at the top of the page to
create a new repository with this repo as the initial state.

If you want to get started manually:
```bash
forge init --template lajosdeme/foundry-template new-project
cd new-project
make all
```

You will need Foundry to get started. If you don't have it installed already, check out the
[installation](https://github.com/foundry-rs/foundry#installation) instructions.

## Features
### Testing Helpers:
Includes a `Helper.sol` contract with common testing utilities such as creating users with inital balances and quickly forking blockchains at specific block numbers, selecting and switching between different forks.

### Contract Creation Script:
Includes a bash script that is useful for creating new smart contracts. It automatically sets up boilerplate for the contract (such as SPDX identifier, pragma version), and creates a `<contract_name>.t.sol` file in the `/test` folder and a `Deploy<contract_name>.s.sol` file in the `/script` folder.

You can create your contracts this way:
```bash
# configure permission for the script
chmod +x ./create.sh

# create NewContract.sol, test/NewContract.t.sol, script/DeployNewContract.s.sol
make create name=NewContract
```

### GitHub Actions

This template comes with GitHub Actions pre-configured. Your contracts will be linted and tested on every push and pull
request made to the `main` branch.

You can edit the CI script in [.github/workflows/test.yml](./.github/workflows/test.yml).

### Default Configuration
Including `.gitignore`, `.vscode`, `remappings.txt`

### Audit helpers
You can run `make audit` to run the Slither staic analyzer and the Aderyn audit tool (you have to install them first on your system).

## Acknowledgement
Inspired by:
- https://github.com/foundry-rs/forge-template
- https://github.com/PaulRBerg/foundry-template
- https://github.com/FrankieIsLost/forge-template