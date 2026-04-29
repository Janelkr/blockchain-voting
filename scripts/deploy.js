const hre = require("hardhat");

async function main() {
  const candidateNames = ["Alice", "Bob", "Charlie"];
  const Voting = await hre.ethers.getContractFactory("Voting");
  const voting = await Voting.deploy(candidateNames);
  await voting.deployed();   // правильный метод для hardhat 2
  console.log("Контракт развёрнут по адресу:", voting.address);
}
main().catch(console.error);
