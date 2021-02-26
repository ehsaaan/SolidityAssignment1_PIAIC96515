
pragma solidity ^0.5.0;

contract StudentRegistration {
    address payable private myAddress =
        0xE9803d4af315DcDe7dFAfe0Ef8E90008C130E92A;

    enum gender {male, female}
    enum category {online, onsite}

    mapping(address => Student) public studentList;
    uint256 private collectedDues;
    uint256 private totalRegisterdStudents;

    struct Student {
        string name;
        address sdtAddress;
        bool hasBSDegree;
        gender _gender;
        category _category;
    }

    function setAddress(address payable add) public {
        myAddress = add;
    }

    function getAddress() public view returns (address) {
        return myAddress;
    }

    function getBalance() public view returns (uint256) {
        return myAddress.balance;
    }

    function payment(
        string memory name,
        bool hasBSDegree,
        gender _gender,
        category _category
    ) public payable {
        require(msg.value == 2 ether, "Two Ethereum required for enrollment");
        require(
            studentList[msg.sender].sdtAddress == address(0x0),
            "Student Exists"
        );
        Student memory std =
            Student(name, msg.sender, hasBSDegree, _gender, _category);
        studentList[msg.sender] = std;

        myAddress.transfer(msg.value);
        collectedDues = collectedDues + msg.value;
        totalRegisterdStudents++;
    }

    function getCollectedDues() public view returns (uint256) {
        return collectedDues;
    }

    function getTotalEnrolledStds() public view returns (uint256) {
        return totalRegisterdStudents;
    }

    function getStudentDetails(address studentId)
        public
        view
        returns (
            address,
            string memory,
            bool,
            gender,
            category
        )
    {
        return (
            studentList[studentId].sdtAddress,
            studentList[studentId].name,
            studentList[studentId].hasBSDegree,
            studentList[studentId]._gender,
            studentList[studentId]._category
        );
    }
}
