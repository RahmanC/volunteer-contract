// This setup uses Hardhat Ignition to manage smart contract deployments.
// Learn more about it at https://hardhat.org/ignition

import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const REWARD_RATE_PER_HOUR = 10n * 10n ** 18n; // 10 tokens per hour

const VolunteerContractModule = buildModule("VolunteerContractModule", (m) => {
  const rewardRatePerHour = m.getParameter(
    "rewardRatePerHour",
    REWARD_RATE_PER_HOUR
  );

  const volunteerContract = m.contract("VolunteerContract", [
    "0xF2d5E0Da6C9D29fCF222856B576F61b8ad6774e7",
    rewardRatePerHour,
  ]);

  return { volunteerContract };
});

export default VolunteerContractModule;
