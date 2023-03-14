const contract = artifacts.require('userContract.sol')


module.exports = function (deployer) {
    deployer.deploy(contract)
}