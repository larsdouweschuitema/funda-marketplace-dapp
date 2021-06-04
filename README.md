<div align="center">
  <img width="200" src="docs/funda-marketplace-dapp.png" alt="funda Marketplace DApp">
  <h1>funda Marketplace DApp</h1>
</div>

We created a decentralized application using blockchain technology.​
​
Now, funda is not only a marketplace, but also an intermediary for buying and selling real estate, disrupting notary services.

## Table of contents

- [Features](#features)
- [Installation](#installation)
- [Production](#production)

## Features
- Replacing the intermediaries.​
- Enable funda to support real estate transactions more comprehensively ​
- Introduce new ways to trade real estate.​
- Enable fractional ownership to lower the barriers to real estate investing 

## Installation
```bash
# clone repository and change to its directory
$ git clone git@github.com:larsdouweschuitema/funda-marketplace-dapp.git
$ cd funda-marketplace-dapp

# install dependencies using npm
$ npm install

# serve with hot reload at localhost:3000
$ npm run dev
```

## Production
```bash
# build for production and launch server
$ npm run build
$ npm run start
```

## Tech stack
- Ethereum asset pipeline `truffle` 
- Vue framework `nuxt` including:
  - Runtime environment `node`
  - Client side framework `vue`
  - Module bundler `webpack`
- Package manager `npm`
- UI Framework `tailwindcss`
  - Shared funda configuration `@funda/tailwind-config`
- Vue Component Library `@funda/ui`
- Development experience/consistency + Linters `eslint`, `prettier`, `commitlint`, `lint-staged` and `.editorconfig`
- Shared funda icons `@funda/icons`
