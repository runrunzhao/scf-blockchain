const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("CustomToken", function () {
    let Token, token, owner, addr1;

    beforeEach(async function () {
        Token = await ethers.getContractFactory("CustomToken");
        [owner, addr1] = await ethers.getSigners();
        token = await Token.deploy("MyToken", "MTK");
        await token.deployed();
    });

    it("Should have correct name and symbol", async function () {
        expect(await token.name()).to.equal("MyToken");
        expect(await token.symbol()).to.equal("MTK");
    });

    it("Should allow owner to mint tokens", async function () {
        await token.mint(addr1.address, ethers.utils.parseEther("100"));
        expect(await token.balanceOf(addr1.address)).to.equal(ethers.utils.parseEther("100"));
    });

    it("Should not allow non-owner to mint tokens", async function () {
        await expect(
            token.connect(addr1).mint(addr1.address, ethers.utils.parseEther("100"))
        ).to.be.revertedWith("Ownable: caller is not the owner");
    });
});