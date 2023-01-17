var mysql = require("mysql");
const mysql2 = require("mysql2-promise")();
const connectionString = {
  host: "localhost",
  user: "root",
  password: "",
  database: "final_project",
};
const db = mysql.createConnection(connectionString);
mysql2.configure(connectionString);

try {
  db.connect(console.log("Database bağlantısı başarılı !"));
} catch (error) {
  console.log(error);
}
module.exports = { db, mysql2 };
