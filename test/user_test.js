
const UserContract = artifacts.require("userContract.sol")

const fromWei = (val) => {
    return web3.utils.fromWei(val, 'ether')
}

const toWei = (val) => {
    return web3.utils.toWei(val.toString(), 'ether')
}

module.exports = async function (callback) {
    const userContract = await UserContract.deployed()
    let res = await userContract.createUser("0x669e59B766c0136339EbDE46AF45b7D6EfE836b2", "sad")
    console.log('number', res);
    // let addr0 = await userContract.userAddresses.call()
    // console.log(addr0);

    // let res = await userContract.createNews('123','jack','0x3aCD2558b0AFda731fC13bff4cCEcC3546617fb0')
    // console.log(res);
    // console.log(newsHashList);
    let flag = await userContract.isExitUsername('user')
    console.log(flag);

    callback()
}