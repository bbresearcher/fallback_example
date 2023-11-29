import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("FallbackTest", function () {
  async function deployCalledFixture() {
   
    const [owner, otherAccount] = await ethers.getSigners();

    const Called = await ethers.getContractFactory("Called");
    const called = await Called.deploy();

    return { called, owner, otherAccount };
  }

  describe("Deployment", function () {
    it("Create a Caller contract and check value is 10000", async function () {
      const SOME_ETHER = 10000;
      const { called, owner, otherAccount } = await loadFixture(deployCalledFixture);
      const Caller = await ethers.getContractFactory("Caller");
      const caller = await Caller.deploy(called.address,{value: SOME_ETHER});

      expect(await ethers.provider.getBalance(caller.address)).to.equal(SOME_ETHER);
    });

    it("Create a CallerWithRevert contract and check value is 10000", async function () {
      const SOME_ETHER = 10000;
      const { called, owner, otherAccount } = await loadFixture(deployCalledFixture);
      const CallerWithRevert = await ethers.getContractFactory("CallerWithRevert");
      const callerWithRevert = await CallerWithRevert.deploy(called.address,{value: SOME_ETHER});

      expect(await ethers.provider.getBalance(callerWithRevert.address)).to.equal(SOME_ETHER);
    });

    it("Create a CallerWithRevert but not send money contract and check value is 10000", async function () {
      const SOME_ETHER = 10000;
      const { called, owner, otherAccount } = await loadFixture(deployCalledFixture);
      called.sendMeMoney({value: SOME_ETHER});
      const CallerWithRevert = await ethers.getContractFactory("CallerWithRevert");
      const callerWithRevert = await CallerWithRevert.deploy(called.address,{value: 0});

      expect(await ethers.provider.getBalance(callerWithRevert.address)).to.equal(SOME_ETHER);
    });
    });
  });