module.exports = (sequelize, Sequelize) => {
    const Major_science = sequelize.define("major_science", {
      name: {
        type: Sequelize.STRING
      }
    });
  
    return Major_science;
  };