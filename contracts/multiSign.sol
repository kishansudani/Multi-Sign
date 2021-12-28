pragma solidity ^0.8.4;

contract MultiSign {

    struct DocDetails {
        uint8 totalSignRequiredForUpdate;
        string docURL;
        address owner;
        mapping(string => uint8) signGotForUpdate;
        mapping(string => address) lastUpdatedBy;
        // mapping(address => bool) signedRequired;
        address[] signedRequired;
    }

    DocDetails[] docDetails;

    mapping (string => uint) docIndexes;

    function addDocument(string _doc, uint8 _totalSignedRequired, address[] memory signers) 
        public
        returns(uint256)
    {
        require(bytes(_doc).length != 0);
        require(_totalSignedRequired != 0);
        require(_totalSignedRequired <= signers.length);
        DocDetails memory doc;
        doc.totalSignRequiredForUpdate = _totalSignedRequired;
        doc.docURL = _doc;
        doc.owner = msg.sender;
        doc.signedRequired = signers;
        docDetails.push(doc);
        docIndexes[_doc] = docDetails.length - 1;
        return docDetails.length - 1;
    }

}