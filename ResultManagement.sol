//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract ResultManagement{
    
    uint32 public student_id = 0;

    struct Student{
        string name;
        string studID;
        string progCode;
        uint32 Part;
        uint32 sub1;
        uint32 sub2;
        uint32 sub3;
        uint32 sub4;
        uint32 sub5;
        uint32 gpa;
    }

    mapping(uint32 => Student) public Students;

    function calcGPA(uint32 a, uint32 b, uint32 c, uint32 d, uint32 e, uint32 f) public view returns (uint32){
        if(f==1){
            uint32 totSub1 = a * 4;
            uint32 totSub2 = b * 3;
            uint32 totSub3 = c * 3;
            uint32 totSub4 = d * 3;
            uint32 totSub5 = e * 2;
            uint32 gpa = ((totSub1 + totSub2 + totSub3 + totSub4 + totSub5)/15);
            return gpa;
        }
        else if(f==2){
            uint32 totSub1 = a * 4;
            uint32 totSub2 = b * 4;
            uint32 totSub3 = c * 3;
            uint32 totSub4 = d * 3;
            uint32 totSub5 = e * 2;
            uint32 gpa = ((totSub1 + totSub2 + totSub3 + totSub4 + totSub5)/16);
            return gpa;
        }
        else if(f==3){
            uint32 totSub1 = a * 4;
            uint32 totSub2 = b * 4;
            uint32 totSub3 = c * 3;
            uint32 totSub4 = d * 3;
            uint32 totSub5 = e * 3;
            uint32 gpa = ((totSub1 + totSub2 + totSub3 + totSub4 + totSub5)/17);
            return gpa;
        }
        else if(f==4){
            uint32 totSub1 = a * 4;
            uint32 totSub2 = b * 4;
            uint32 totSub3 = c * 4;
            uint32 totSub4 = d * 3;
            uint32 totSub5 = e * 3;
            uint32 gpa = ((totSub1 + totSub2 + totSub3 + totSub4 + totSub5)/18);
            return gpa;
        }
        else if(f==5){
            uint32 totSub1 = a * 4;
            uint32 totSub2 = b * 4;
            uint32 totSub3 = c * 4;
            uint32 totSub4 = d * 4;
            uint32 totSub5 = e * 3;
            uint32 gpa = ((totSub1 + totSub2 + totSub3 + totSub4 + totSub5)/19);
            return gpa;
        }
        else if(f==6){
            uint32 totSub1 = a * 4;
            uint32 totSub2 = b * 4;
            uint32 totSub3 = c * 4;
            uint32 totSub4 = d * 4;
            uint32 totSub5 = e * 4;
            uint32 gpa = ((totSub1 + totSub2 + totSub3 + totSub4 + totSub5)/20);
            return gpa;
        }
        else{
            return 101;
        }
    }

    function addStudentMarks(string memory _name, string memory _studID, string memory _progCode, uint32 _part, uint32 _sub1, uint32 _sub2, uint32 _sub3, uint32 _sub4, uint32 _sub5) public returns (uint32){
        uint32 userId = student_id++;
        Students[userId].name = _name;
        Students[userId].studID = _studID;
        Students[userId].progCode = _progCode;
        Students[userId].Part = _part;
        Students[userId].sub1 = _sub1;
        Students[userId].sub2 = _sub2;
        Students[userId].sub3 = _sub3;
        Students[userId].sub4 = _sub4;
        Students[userId].sub5 = _sub5;
        uint32 _gpa = calcGPA(_sub1,_sub2,_sub3,_sub4,_sub5,_part);
        Students[userId].gpa = _gpa;
        return userId;
    }


    function getCurrentStudent(string memory _studID) public view returns (string memory a, string memory b, string memory c, uint32 d, uint32 e, uint32 f, uint32 g, uint32 h, uint32 i, uint32 k){
        for(uint32 j = 0; j<student_id;j++){
            if(keccak256(abi.encodePacked(Students[j].studID)) == keccak256(abi.encodePacked(_studID))){
                return (Students[j].name, Students[j].studID, Students[j].progCode, Students[j].Part, Students[j].sub1, Students[j].sub2, Students[j].sub3, Students[j].sub4, Students[j].sub5, Students[j].gpa);
            }
        }
    }

    /*function listAllStudents() public view returns (string memory a, string memory b, string memory c, uint32 d, uint32 e, uint32 f, uint32 g, uint32 h, uint32 i){
        for(uint32 j = 0; j<student_id;j++){
            return (Students[j].name, Students[j].studID, Students[j].progCode, Students[j].Part, Students[j].sub1, Students[j].sub2, Students[j].sub3, Students[j].sub4, Students[j].sub5);
        }
    }*/

    function listAllStudents() public view returns (Student[] memory){
      Student[] memory lStudents = new Student[](student_id);
      for (uint32 i = 0; i < student_id; i++) {
          Student storage lStudent = Students[i];
          lStudents[i] = lStudent;
      }
      return lStudents;
    }
}