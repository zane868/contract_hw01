import { network } from "hardhat";

// 合约 owner 地址
const OWNER = "0xEeBD193Cb96D61E93D22FdAeD12313E2BeC8ef6c";

// 使用 --network 指定的网络（例如 --network sepolia）
const { ethers } = await network.create();

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deployer (pays gas):", deployer.address);

  // 1. 部署实现合约 Voting，并等待其确认上链
  const implementation = await ethers.deployContract("Voting");
  await implementation.waitForDeployment();
  const implementationAddress = await implementation.getAddress();
  console.log("Voting implementation:", implementationAddress);

  // 2. 编码初始化调用 initialize(owner)
  const initData = implementation.interface.encodeFunctionData("initialize", [
    OWNER,
  ]);

  // 3. 部署 ERC1967 代理（VotingProxy 即 ERC1967Proxy），指向实现合约
  const proxy = await ethers.deployContract("VotingProxy", [
    implementationAddress,
    initData,
  ]);
  await proxy.waitForDeployment();
  const proxyAddress = await proxy.getAddress();
  console.log("Proxy (interact with this):", proxyAddress);

  // 4. 通过代理读取状态，验证 owner 与候选人
  const voting = await ethers.getContractAt("Voting", proxyAddress);
  console.log("Owner:", await voting.owner());
  console.log("Candidates:", await voting.GetAllCandidate());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
