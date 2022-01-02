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
    contractAddress = 
    await this.lucid.connect(owner).whitelist([userAddress, user2Address], ['11', '33']);
 });
  it("should whitelist a user to take a longhorn", async function () {
    const userApprovalX = await this.lucid.isApprovedOrOwner(userAddress, '11');
    const user2ApprovalX = await this.lucid.isApprovedOrOwner(user2Address, '11');
    const userApprovalY = await this.lucid.isApprovedOrOwner(userAddress, '33');
    const user2ApprovalY = await this.lucid.isApprovedOrOwner(user2Address, '33');
    expect(userApprovalX).to.eq(true);
    expect(user2ApprovalX).to.eq(false);
    expect(userApprovalY).to.eq(false);
    expect(user2ApprovalY).to.eq(true);
  });
  it("should allow a user to get their longhorn", async function () {
    await this.lucid.connect(user).claim('11');
    await this.lucid.connect(user2).claim('33');
    expect(await this.lucid.ownerOf('11')).to.eq(userAddress);
    expect(await this.lucid.ownerOf('33')).to.eq(user2Address);
  });
  it("should revert when a user claims the wrong longhorn", async function () {
    await expect(this.lucid.connect(user).claim('33')).to.be.revertedWith("Not approved to take this longhorn");
    await this.lucid.connect(user).claim('11');
    await expect(this.lucid.connect(user2).claim('11')).to.be.revertedWith("Not approved to take this longhorn");
  });
});
