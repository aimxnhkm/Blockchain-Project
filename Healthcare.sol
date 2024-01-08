//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

contract Healthcare{

    uint32 public pa_ID = 1;
    uint32 public health_ID = 1;


    /*
    modifier OnlyOwner(){
        require(msg.sender == owner,"ONLY ADMIN IS ALLOWED");
        _;
    }
    
    modifier Only_Doctors{
        require(DoctorInfo[msg.sender].state == true,"REGISTERED DOCTORS ONLY");
        _;
    }
    
    modifier Only_Patients{
        require(PatientInfo[msg.sender].state == true,"REGISTERED PATIENTS ONLY");
        _;
    }
    */

     
    struct Patient{
        string PatientName; // Patient Name
        string PatientICNumber; // Patient I/C Number
        string PatientContno; // Patient Contact Number
        string PatientGender; // Patient Gender
        string PatientEmail; // Patient Email
        string PatientAdd; // Patient Address
        uint32 PatientAge; // Patient Age
        string PatientMedhis; // Patient Medical History
        string[] pa_Records; // Used to store the prescription records of corresponding patients
    }

     mapping(uint32 => Patient) public Patients;


    struct MedicalDetails{
        string BloodPressure; 
        string BloodSugar;
        string Weight;
        string Temperature;
        string MedicalPres; // Prescription details of patient given by doctor
    }

    mapping(uint32 => MedicalDetails) public HealthRecord;


    // Function to add Patient details, done by registered doctors only
    function setPatientDetails(string memory _PatientName, string memory _PatientICNumber, 
    string memory _PatientContno, string memory _PatientGender, string memory _PatientEmail, 
    string memory _PatientAdd, uint32 _PatientAge, string memory _PatientMedhis) 
    public returns (uint32){
        uint32 patientId = pa_ID++;
        Patients[patientId].PatientName = _PatientName;
        Patients[patientId].PatientICNumber = _PatientICNumber;
        Patients[patientId].PatientContno = _PatientContno;
        Patients[patientId].PatientGender = _PatientGender;
        Patients[patientId].PatientEmail = _PatientEmail;
        Patients[patientId].PatientAdd = _PatientAdd;
        Patients[patientId].PatientAge = _PatientAge;
        Patients[patientId].PatientMedhis = _PatientMedhis;
        return patientId;
    }
    


     // Function to add Healthcare records of patients, done by registered doctors only
    function setHealthRecords(string memory _BloodPressure, string memory _BloodSugar, 
    string memory _Weight, string memory _Temperature, string memory _MedicalPres) 
    public returns (uint32){
        uint32 record_Id = health_ID++;
        HealthRecord[record_Id].BloodPressure = _BloodPressure;
        HealthRecord[record_Id].BloodSugar =  _BloodSugar;
        HealthRecord[record_Id].Weight = _Weight;
        HealthRecord[record_Id].Temperature = _Temperature;
        HealthRecord[record_Id].MedicalPres = _MedicalPres;
        return record_Id;
    }


    // Function to get Patient details
    /* Keccak256 is a cryptographic function built into solidity. 
       This function takes in any amount of inputs and converts it to a unique 32 byte hash.*/
    function getPatientDetails(string memory _PatientICNumber) public view returns
    (string memory Name, string memory PatientICNumber, string memory ContactNo, 
    string memory Gender, string memory Email, string memory Address, uint32 Age, 
    string memory MedicalHistory)
    {
        for(uint32 i = 0; i<pa_ID; i++) 
        {
            if(keccak256(abi.encodePacked(Patients[i].PatientICNumber)) == 
            keccak256(abi.encodePacked(_PatientICNumber)))
            {
                return (Patients[i].PatientName, Patients[i].PatientICNumber, 
                Patients[i].PatientContno, Patients[i].PatientGender, Patients[i].PatientEmail, 
                Patients[i].PatientAdd, Patients[i].PatientAge, Patients[i].PatientMedhis);
            }
        }
    }



     // Function to get Healthcare Medical Records
    function getHealthRecords(string memory _PatientICNumber) public view returns
    (string memory BloodPressure, string memory BloodSugar, string memory Weight, 
    string memory Temperature, string memory MedicalPrescription) 
    {
        for(uint32 k = 0; k<health_ID; k++)
        {
            if(keccak256(abi.encodePacked(Patients[k].PatientICNumber)) == 
            keccak256(abi.encodePacked(_PatientICNumber)))
            {
                return (HealthRecord[k].BloodPressure, HealthRecord[k].BloodSugar, 
                HealthRecord[k].Weight, HealthRecord[k].Temperature, 
                HealthRecord[k].MedicalPres);
            }
        }
    }
}