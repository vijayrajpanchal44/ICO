const { expect } = require("chai");
const { ethers, hre } = require("hardhat");
require("@nomiclabs/hardhat-waffle");


describe("ICO", async function () {
    let ICO;

    beforeEach(async () => {
        const [owner] = await ethers.getSigners();
       
        const ico = await ethers.getContractFactory("ICO");

        
    })

    it("Should deploy only on goerli network", async function () {
        const ico = await ethers.getContractFactory("ICO");
        ICO = await ico.deploy();

        expect(await contractAddress.balanceOfPetals(contractOwner, 1)).to.equal(1);
    });
})