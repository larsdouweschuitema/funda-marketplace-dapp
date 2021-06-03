// SPDX-License-Identifier: MIT
const Auction = artifacts.require("Auction");

module.exports = function (deployer) {
  deployer.deploy(Auction);
};