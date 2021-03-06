const { expect } = require("chai");
let user,user2,owner;
let userAddress, ownerAddress, user2Address;
let Token;
let hardhatToken;

describe("Lucid Longhorn", function () {
  beforeEach(async function () {
    [owner,user,user2] = await ethers.getSigners();
    Token = await ethers.getContractFactory("LucidLonghorn");
    this.lucid = await Token.deploy();
    userAddress = user.address;
    user2Address = user2.address;
    ownerAddress = owner.address;
    await this.lucid.connect(owner).whitelist([userAddress, user2Address], ['2111', '3311']);
  });
describe("Mint and allocate", function() {
  it("should whitelist a user to take a longhorn", async function () {
    const userApprovalX = await this.lucid.isApprovedOrOwner(userAddress, '2111');
    const user2ApprovalX = await this.lucid.isApprovedOrOwner(user2Address, '2111');
    const userApprovalY = await this.lucid.isApprovedOrOwner(userAddress, '3311');
    const user2ApprovalY = await this.lucid.isApprovedOrOwner(user2Address, '3311');
    expect(userApprovalX).to.eq(true);
    expect(user2ApprovalX).to.eq(false);
    expect(userApprovalY).to.eq(false);
    expect(user2ApprovalY).to.eq(true);
  });
  it("should allow a user to get their longhorn", async function () {
    await this.lucid.connect(user).claim('2111');
    await this.lucid.connect(user2).claim('3311');
    expect(await this.lucid.ownerOf('2111')).to.eq(userAddress);
    expect(await this.lucid.ownerOf('3311')).to.eq(user2Address);
  });
  it("should revert when a user claims the wrong longhorn", async function () {
    await expect(this.lucid.connect(user).claim('3311')).to.be.revertedWith("Not approved to take this longhorn");
    await this.lucid.connect(user).claim('2111');
    await expect(this.lucid.connect(user2).claim('2111')).to.be.revertedWith("Not approved to take this longhorn");
  });
});
describe("Transfer", function () {
  it("reverts when a user transfers a longhorn they do not own", async function () {
    await expect(this.lucid.connect(user).transfer(user2Address, '2111')).to.be.revertedWith("ERC721: transfer of token that is not own");
    await expect(this.lucid.connect(user).transfer(user2Address, '3511')).to.be.revertedWith("ERC721: owner query for nonexistent token");
    await this.lucid.connect(user).claim('2111');
    await expect(this.lucid.connect(user).transfer(user2Address, '3311')).to.be.revertedWith("ERC721: transfer of token that is not own");
  });
  it("allows users to transfer their NFT to other users", async function () {
    await this.lucid.connect(user).claim('2111');
    await this.lucid.connect(user).transfer(user2Address, '2111');
    expect(await this.lucid.ownerOf('2111')).to.eq(user2Address);
  });
  it("clears approval upon a transfer", async function () {
    await this.lucid.connect(user).claim('2111');
    await this.lucid.connect(user).transfer(user2Address, '2111');
    expect(await this.lucid.isApprovedOrOwner(userAddress, '2111')).to.eq(false);
    expect(await this.lucid.isApprovedOrOwner(user2Address, '2111')).to.eq(true);
    expect(await this.lucid.isApprovedOrOwner(user2Address, '3311')).to.eq(true);
  });
});
describe("Buy", function () {
  it("gives a bronze longhorn for .1 ETH", async function () {
    await this.lucid.connect(user).buyBronze({value: ethers.utils.parseEther("0.1")});
    await this.lucid.connect(user2).buyBronze({value: ethers.utils.parseEther("0.1")});
    expect(await this.lucid.ownerOf('0')).to.eq(userAddress);
    expect(await this.lucid.ownerOf('1')).to.eq(user2Address);
    await expect(this.lucid.connect(user).buyBronze({value: ethers.utils.parseEther("0.099")})).to.be.revertedWith("Not enough ETH");
  });
  it("gives a silver longhorn for .5 ETH", async function () {
    await this.lucid.connect(user).buySilver({value: ethers.utils.parseEther("0.25")});
    await this.lucid.connect(user2).buySilver({value: ethers.utils.parseEther("0.25")});
    expect(await this.lucid.ownerOf('200')).to.eq(userAddress);
    expect(await this.lucid.ownerOf('201')).to.eq(user2Address);
    await expect(this.lucid.connect(user).buySilver({value: ethers.utils.parseEther("0.24")})).to.be.revertedWith("Not enough ETH");
  });
  it("gives a gold longhorn for 1 ETH", async function () {
    await this.lucid.connect(user).buyGold({value: ethers.utils.parseEther("1.0")});
    await this.lucid.connect(user2).buyGold({value: ethers.utils.parseEther("1.0")});
    expect(await this.lucid.ownerOf('250')).to.eq(userAddress);
    expect(await this.lucid.ownerOf('251')).to.eq(user2Address);
    await expect(this.lucid.connect(user).buyGold({value: ethers.utils.parseEther(".99")})).to.be.revertedWith("Not enough ETH");
  });
  it("gives a legendary longhorn for 3 ETH", async function () {
    await this.lucid.connect(user).buyLegendary({value: ethers.utils.parseEther("3.0")});
    await this.lucid.connect(user2).buyLegendary({value: ethers.utils.parseEther("3.0")});
    expect(await this.lucid.ownerOf('270')).to.eq(userAddress);
    expect(await this.lucid.ownerOf('271')).to.eq(user2Address);
    await expect(this.lucid.connect(user).buyLegendary({value: ethers.utils.parseEther("2.99")})).to.be.revertedWith("Not enough ETH");
  });
  it("does not overflow", async function () {
    await this.lucid.connect(owner).withdraw();
    await this.lucid.connect(user).buyLegendary({value: ethers.utils.parseEther("21.0")});
    await this.lucid.connect(user).buyLegendary({value: ethers.utils.parseEther("20.0")});
    await this.lucid.connect(user).buyLegendary({value: ethers.utils.parseEther("30.0")});
    await this.lucid.connect(user).buyLegendary({value: ethers.utils.parseEther("40.0")});
    await this.lucid.connect(user).buyLegendary({value: ethers.utils.parseEther("24.0")});
    expect(await this.lucid.ownerOf('270')).to.eq(userAddress);
    expect(await this.lucid.ownerOf('271')).to.eq(userAddress);
    expect(await this.lucid.ownerOf('272')).to.eq(userAddress);
    expect(await this.lucid.ownerOf('273')).to.eq(userAddress);
    expect(await this.lucid.ownerOf('274')).to.eq(userAddress);
    expect(await this.lucid.contractBalance()).to.eq('100000000000000000000');
    await expect(this.lucid.connect(user).buyLegendary({value: ethers.utils.parseEther("24.0")})).to.be.revertedWith("No more legendary lucid longhorns for sale");
  });
});
describe("Miscellaneous", function () {
  it("does not allow other users to claim a non-existant NFT", async function () {
    await expect(this.lucid.connect(user).claim('32')).to.be.revertedWith('ERC721: operator query for nonexistent token');
  });
  it('properly withdraws ETH from the contract', async function () {
    await this.lucid.connect(owner).withdraw();
    expect(await this.lucid.connect(owner).contractBalance()).to.eq('0');
  });
  it('returns excess ETH when a user deposits more than required', async function () {
    await this.lucid.connect(user).buyGold({value: ethers.utils.parseEther("2.0")});
    expect(await this.lucid.contractBalance()).to.eq('1000000000000000000');
  });
});
});
