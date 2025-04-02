const hre = require("hardhat");

async function main() {
    const Token = await hre.ethers.getContractFactory("CustomToken");
    const token = await Token.deploy("MyToken", "MTK");

    await token.deployed();
    console.log("Token deployed to:", token.address);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});