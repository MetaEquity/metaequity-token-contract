
var MetaCoinToken = artifacts.require("MetaCoinToken.sol");

module.exports = function(deployer) {
  
    console.log("deploy started -  MetaCoinToken");
    
    deployer.deploy(MetaCoinToken)
    
    .then(function(){
      console.log("MetaCoinToken deployed at: ", MetaCoinToken.address);

        return;
        

    });
  
};

