async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  console.log("Account balance:", (await deployer.getBalance()).toString());

  const InitFactory = await ethers.getContractFactory("Init");
  const InitDeploy = await InitFactory.deploy();
  await InitDeploy.deployed();
  const LonghornFactory = await ethers.getContractFactory("LucidLonghorn", {
	  libraries: {
		  LibConstants: "0x09F05275BF370a7C354C2c64DB3656d484433FFb",
	  },
  });
  const LonghornDeploy = await LonghornFactory.deploy();
  await LonghornDeploy.deployed();

  console.log("Init address:", InitDeploy.address);
  console.log("Main Contract (Lucid Longhorn) address:", LonghornDeploy.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
