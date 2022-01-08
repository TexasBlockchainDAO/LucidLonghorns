async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  console.log("Account balance:", (await deployer.getBalance()).toString());

  const LibraryFactory = await ethers.getContractFactory("LibConstants");
  const LibraryDeploy = await LibraryFactory.deploy();
  await LibraryDeploy.deployed();
  const LibraryAddress = LibraryDeploy.address;
  console.log(LibraryAddress);

  const InitFactory = await ethers.getContractFactory("Init");
  const InitDeploy = await InitFactory.deploy();
  await InitDeploy.deployed();
  const LonghornFactory = await ethers.getContractFactory("LucidLonghorn")
  const LonghornDeploy = await LonghornFactory.deploy();
  await LonghornDeploy.deployed();

  console.log("Init address: ", InitDeploy.address);
  console.log("Main Contract (Lucid Longhorn) address: ", LonghornDeploy.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
