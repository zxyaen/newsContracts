
const UserContract = artifacts.require("userContract.sol")

const fromWei = (val) => {
    return web3.utils.fromWei(val, 'ether')
}

const toWei = (val) => {
    return web3.utils.toWei(val.toString(), 'ether')
}

module.exports = async function (callback) {
    const userContract = await UserContract.deployed()
    // let number = await userContract.createUser("0x21690371Cf066b2e0f7cB78E6D951b62abbBa431", "uuu")
    // console.log('number', number);
    // let addr0 = await userContract.userAddresses.call()
    // console.log(addr0);

    let flag = await userContract.isExitUsername('user')
    console.log(flag);

    callback()
}