// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.17;

// Importing OpenZeppelin's SafeMath Implementation
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

// IERC-20 contract
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract NorweezCrowdfund {
    // SafeMath for safe integer operations
    using SafeMath for uint256;

    // List of all the projects
    Project[] private projects;

    // event for when new project starts
    event ProjectStarted(
        address contractAddress,
        address projectCreator,
        string title,
        string description,
        string imageLink,
        uint256 goalAmount
    );

    function startProject(
        ERC20 DAI,
        string calldata title,
        string calldata description,
        string calldata imageLink,
        uint amountToRaise
    ) external {

        Project newProject = new Project(DAI, payable(msg.sender), title, description, imageLink, amountToRaise);
        projects.push(newProject);

        emit ProjectStarted(
            address(newProject),
            msg.sender,
            title,
            description,
            imageLink,
            amountToRaise
        );
    }

    function returnProjects() external view returns(Project[] memory) {
        return projects;
    }

}


contract Project {
    using SafeMath for uint256;

    enum ProjectState {
        Fundraising,
        Successful
    }
    ERC20 private DAI;

    // Initialize public variables
    address payable public creator;
    uint public goalAmount;
    uint public completeAt;
    uint256 public currentBalance;
    string public title;
    string public description;
    string public imageLink;

    // Initialize state at fundraising
    ProjectState public state = ProjectState.Fundraising;

    mapping (address => uint) public contributions;

    // Event when funding is received
    event ReceivedFunding(address contributor, uint amount, uint currentTotal);

    // Event for when the project creator has received their funds
    event CreatorPaid(address recipient);

    modifier theState(ProjectState _state) {
        require(state == _state);
        _;
    }

    constructor
    (
        ERC20 token,
        address payable projectCreator,
        string memory projectTitle,
        string memory projectDescription,
        string memory projectImageLink,
        uint projectGoalAmount
    ) {
        DAI = token;
        creator = projectCreator;
        title = projectTitle;
        description = projectDescription;
        imageLink = projectImageLink;
        goalAmount = projectGoalAmount;
        currentBalance = 0;
    }

    // Fund a project
    function contribute(uint256 amount) external theState(ProjectState.Fundraising) payable {
        DAI.transferFrom(msg.sender, address(this), amount);

        contributions[msg.sender] = contributions[msg.sender].add(amount);
        currentBalance = currentBalance.add(amount);
        emit ReceivedFunding(msg.sender, amount, currentBalance);

    }


    function payOut() external returns (bool result) {
        require(msg.sender == creator);

        uint256 totalRaised = currentBalance;
        currentBalance =  0;

        if (DAI.transfer(msg.sender, totalRaised)) {
            emit CreatorPaid(creator);
            state = ProjectState.Successful;
            return  true;
        }
        else {
            currentBalance = totalRaised;
            state = ProjectState.Successful;
        }

        return  false;
    }

    function getDetails() public  view  returns
    (
        address payable projectCreator,
        string memory projectTitle,
        string memory projectDescription,
        string memory projectImageLink,
        ProjectState currentState,
        uint256 projectGoalAmount,
        uint256 currentAmount
    ) {
        projectCreator = creator;
        projectTitle = title;
        projectDescription = description;
        projectImageLink = imageLink;
        currentState = state;
        projectGoalAmount = goalAmount;
        currentAmount = currentBalance;
    }
}
