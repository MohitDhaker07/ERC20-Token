pragma solidity ^0.6.0;

// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.0/contracts/token/ERC20/IERC20.sol
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract  Block is IERC20 {

    string public name = "Mohit";
    string public symbol = "MDCPT";

    uint public decimal  = 0;
    uint public override totalSupply;
    address public founder;
    mapping(address => uint) public balances;
    mapping( address => mapping(address =>uint)) allowed;

    constructor() public {
        totalSupply = 10000000;
        founder = msg.sender;
        balances[founder] = totalSupply;
    }

    function balanceOf(address tokenOwner) public view override returns(uint){
        return balances[tokenOwner];
    }

    function transfer(address to, uint tokens) public override returns(bool success){
        require(balances[msg.sender]>=tokens);
        balances[to]+=tokens;
        balances[msg.sender]-=tokens;
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    function approve(address spender, uint token) public override returns(bool success){
        require(balances[msg.sender]>=token);
        require(token>0);
        allowed[msg.sender][spender] = token;
        return true;
    }

    function allowance(address tokenOwner, address spender) public view override returns(uint noOfTokens){
        return allowed[tokenOwner][spender];
    }

    function transferFrom(address from, address to, uint tokens) public override returns(bool success){
        require(allowed[from][to]>=tokens);
        require(balances[from]>=tokens);
        balances[from]+=tokens;
        balances[to]-=tokens;
        return true;
    }




    


}