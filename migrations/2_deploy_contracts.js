const Vacunacion = artifacts.require("Vacunacion");

module.exports = function(deployer) {
  deployer.deploy(Vacunacion);
};