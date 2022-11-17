const hre = require("hardhat");

async function main() {

  const ICOContract = await hre.ethers.getContractFactory("ICO");
  const icoContract = await ICOContract.deploy();

  await icoContract.deployed();

  console.log("ICO contract is deployed on: ", icoContract.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
