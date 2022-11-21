const { expect } = require("chai");
const { ethers, hre } = require("hardhat");
require("@nomiclabs/hardhat-waffle");

describe.only("Initial Coin Offering (ICO) contract", async function () {
  let accounts;
  let ico;
  let icoContract;
  const amount = ethers.utils.parseEther("1");

  beforeEach(async () => {
    accounts = await ethers.getSigners();
    ico = await ethers.getContractFactory("ICO");

    icoContract = await ico.deploy();

    await icoContract.deployed();
  });

  it("Should revert if deploy on other then goerli network", async function () {
    await expect(ico.deploy()).to.be.revertedWith(
      "Please deploy on Goerli testnet"
    );
  });

  it("should revert if tokek amount is zero", async function () {
    await expect(icoContract.calculateTokensPrice(0)).to.be.revertedWith(
      "tokenAmount must be greater than 0"
    );
  });

  it("should transfer rapid token to buyer", async function () {
    const amount = 1000000000000000000n;
    await icoContract.buyRapidTokens(amount, { value: 1500000000000000000n });

    expect(await icoContract.balanceOf(accounts[0].address)).to.equal(amount);
  });

  it("should transfer wei amount if user provide more then needed", async function () {
    const beforeBalance = await accounts[0].getBalance();
    const amounts = ethers.utils.parseUnits("1", "ether");

    await icoContract.buyRapidTokens(1000000000000000000n, { value: amounts });

    const afterBalance = await accounts[0].getBalance();

    const tokenPrice = beforeBalance - afterBalance; // - gas used(gas fee also included)
    console.log(tokenPrice);
    expect(amounts.gt(tokenPrice)).to.equal(true);
  });

  it("Buy token with ether", async function () {
    const wallet = icoContract.connect(accounts[2]);
    await wallet.buyRapidTokens(100000000000000000000n, {
      value: ethers.utils.parseUnits("1", "ether"),
    });
    expect(await wallet.balanceOf(accounts[2].address)).to.equal(
      100000000000000000000n
    );
  });

  it("Do not have enough ether to buy token", async function () {
    const wallet = icoContract.connect(accounts[3]);
    const big_amount = ethers.utils.parseEther("999999");
    const option = { value: big_amount };
    let error;
    try {
      await wallet.buyRapidTokens(option);
    } catch (err) {
      error = "sender doesn't have enough funds";
    }
    expect(error).to.equal("sender doesn't have enough funds"); // maybe can refactor
  });
});
