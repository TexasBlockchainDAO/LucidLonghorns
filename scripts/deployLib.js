async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  console.log("Account balance:", (await deployer.getBalance()).toString());

  const LibraryFactory = await ethers.getContractFactory("LibConstants");
  const LibraryDeploy = await LibraryFactory.deploy();
  await LibraryDeploy.deployed();
  const LibraryAddress = LibraryDeploy.address;

  console.log("Library address:", LibraryAddress);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
