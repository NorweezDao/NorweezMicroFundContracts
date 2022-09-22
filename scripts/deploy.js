async function main() {
  // We get the contract to deploy
  const Seeter = await ethers.getContractFactory("NorweezCrowdfund");
  const seeter = await Seeter.deploy();

  await seeter.deployed();

  console.log("Norweez Fund Contract deployed to:", seeter.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
