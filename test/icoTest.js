const { expect } = require("chai");
const { ethers, hre } = require("hardhat");
require("@nomiclabs/hardhat-waffle");

describe("Initial Coin Offering (ICO) contract", async function () {
    let accounts;
    let ico;
    let icoContract;

    beforeEach(async () => {
        accounts = await ethers.getSigners();
        ico = await ethers.getContractFactory("ICO");

        icoContract = await ico.deploy();

        await icoContract.deployed();
    });

    it("Should revert if deploy on other then goerli network", async function () {
        await expect(ico.deploy()).to.be.revertedWith(
            "ICO: Please deploy on Goerli testnet"
        );
    });

    it("should revert if token amount is zero", async function () {
        await expect(icoContract.calculateTokensPrice(0)).to.be.revertedWith(
            "ICO: tokenAmount must be greater than 0"
        );
    });

    it("should transfer rapid token to buyer", async function () {
        const amount = 1000000000000000000n;
        await icoContract.buyRapidTokens(amount, { value: 1500000000000000000n });

        expect(await icoContract.balanceOf(accounts[0].address)).to.equal(amount);
    });

    it("user should provide equal or more ether to buy rapid token", async function () {
        const amount = 1000000000000000000n;

        const tokenPrice = await icoContract.calculateTokensPrice(amount);

        const weiProvide = tokenPrice - 100;

        await expect(
            icoContract.buyRapidTokens(amount, { value: weiProvide })
        ).to.be.revertedWith("ICO: Insufficient ether amount");
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

    it("Withdraw ether from contract", async function () {
        await icoContract.buyRapidTokens(1000000000000000000000n, {
            value: ethers.utils.parseUnits("1", "ether"),
        });

        const before_withdraw = await accounts[0].getBalance();

        await icoContract.withdraw(100000000000000000n);
        const after_withdraw = await accounts[0].getBalance();

        expect(before_withdraw.lt(after_withdraw)).to.equal(true);
    });

    it.only("Do not have permission to withdraw ether from contract", async function () {
        await icoContract.buyRapidTokens(1000000000000000000000n, {
            value: ethers.utils.parseUnits("1", "ether"),
        });
        const wallet = icoContract.connect(accounts[2]);
        await expect(wallet.withdraw(100000000000000000n)).to.be.reverted;
    });

    it("Transfer adds amount to destination account", async function () {
        await icoContract.buyRapidTokens(1000000000000000000000n, {
            value: ethers.utils.parseUnits("1", "ether"),
        });
        const amount = 1000000000000000000n;

        const tokenPrice = await icoContract.calculateTokensPrice(amount);
        
        await token.transfer(accounts[1].address, amount);
        expect(await icoContract.balanceOf(icoContract.address)).to.equal(amount);
    });
});
