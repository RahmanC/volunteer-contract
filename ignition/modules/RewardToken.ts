// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const INITIAL_SUPPLY = 1_000_000n * 10n ** 18n; // 1 million tokens with 18 decimal places

const RewardTokenModule = buildModule("RewardTokenModule", (m) => {
  const initialSupply = m.getParameter("initialSupply", INITIAL_SUPPLY);

  const rewardToken = m.contract("RewardTokenContract", [initialSupply]);

  return { rewardToken };
});

export default RewardTokenModule;
