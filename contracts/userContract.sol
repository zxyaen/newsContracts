// SPDX-License-Identifier: GPL-3.0
// 指定编译器版本
pragma solidity >0.8.0;

contract userContract {
    constructor() {}

    //合约拥有者（管理员）
    address public owner;

    //定义用户数据结构
    struct UserStruct {
        address userAddress;
        string username;
        uint time;
        uint index;
    }

    //定义用户列表数据结构
    struct UserListStruct {
        address userAddress;
        uint index;
    }

    address[] public userAddresses; //所有地址集合
    // userAddresses.push(0x0987654321098765432109876543210987654321);
    string[] private usernames; //所有用户名集合

    /**
     *  userStruct:{
            0x1234567890123456789012345678901234567890: {
                userAddress: 0x1234567890123456789012345678901234567890,
                username: "Alice",
                time: 1234567890,
                index: 0
            },
            0x0987654321098765432109876543210987654321: {
                userAddress: 0x0987654321098765432109876543210987654321,
                username: "Bob",
                time: 1234567900,
                index: 1
            }
     } 
     */
    mapping(address => UserStruct) private userStruct; //账户个人信息

    /**
     *  userListStruct:{
        "alice": {"userAddress": "0x1234567890abcdef", "index": 0}
        "bob": {"userAddress": "0xabcdef1234567890", "index": 1}
     }
     */
    mapping(string => UserListStruct) private userListStruct; //用户名映射地址

    //user.sol
    //判断用户地址是否存在
    function isExitUserAddress(
        address _userAddress
    ) public view returns (bool isIndeed) {
        if (userAddresses.length == 0) return false;
        return (userAddresses[userStruct[_userAddress].index] == _userAddress);
    }

    //判断用户名是否存在
    function isExitUsername(
        string memory _username
    ) public view returns (bool isIndeed) {
        // 用户名列表为空，直接返回flase
        if (usernames.length == 0) return false;
        // 判断用户列表中是否有username == _username若有则证明用户名存在，返回true否则flase
        return (keccak256(bytes(usernames[userListStruct[_username].index])) ==
            keccak256(bytes(_username)));
    }

    //根据用户名查找对于的address
    function findUserAddressByUsername(
        string memory _username
    ) public view returns (address userAddress) {
        require(isExitUsername(_username));
        return userListStruct[_username].userAddress;
    }

    // 新用户创建事件
    event NewUserCreated(
        address indexed _userAddress,
        string _username,
        uint _timestamp,
        uint _index
    );

    //创建用户信息
    //此处调用此方法的发送者为合约0账户
    function createUser(
        address _userAddress,
        string memory _username
    ) public returns (uint index) {
        require(!isExitUserAddress(_userAddress)); //如果地址已存在则不允许再创建

        userAddresses.push(_userAddress); //地址集合push新地址
        //总用户集合更新新用户信息
        userStruct[_userAddress] = UserStruct(
            _userAddress,
            _username,
            block.timestamp,
            userAddresses.length - 1
        );

        usernames.push(_username); //用户名集合push新用户
        //总用户名集合更新新用户姓名和用户所对应的地址集合
        userListStruct[_username] = UserListStruct(
            _userAddress,
            usernames.length - 1
        );
        emit NewUserCreated(
            _userAddress,
            _username,
            block.timestamp,
            userAddresses.length - 1
        );
        //返回所有用户数量
        return userAddresses.length - 1;
    }

    //获取用户个人信息
    function findUser(
        address _userAddress
    )
        public
        view
        returns (
            address userAddr,
            string memory username,
            uint time,
            uint index
        )
    {
        require(isExitUserAddress(_userAddress));
        return (
            userStruct[_userAddress].userAddress,
            userStruct[_userAddress].username,
            userStruct[_userAddress].time,
            userStruct[_userAddress].index
        );
    }
}
