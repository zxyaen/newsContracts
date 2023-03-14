import json from "./build/contracts/userContract.json" assert { type: "json" };
let abi = json.abi
let address = json.networks[7544].address
// export { abi ,address}
export default {
    abi,
    address
}