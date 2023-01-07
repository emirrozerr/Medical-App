module.exports = (sequelize, Sequelize) => {
    const Specialty = sequelize.define("specialty", {
      name: {
        type: Sequelize.STRING
      },
      major_science_id: {
        type: Sequelize.INTEGER
      }
    });
  
    return Specialty;
};