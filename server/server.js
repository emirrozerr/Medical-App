const express = require("express");
const dotenv = require("dotenv");
const routers = require("./src/routers");
const cors = require("cors");
const fileUpload = require("express-fileupload");

const app = express();
dotenv.config({
  path: "./config/env/config.env",
});

var corsOptions = {
  origin: "*",
  optionsSuccessStatus: 200,
};
app.use(cors(corsOptions));
app.use(express.json());
app.use(fileUpload());
app.use(express.static(__dirname + "/public"));

const PORT = process.env.PORT;
app.use("/api/", routers);

app.listen(PORT, () => {
  console.log(`Uygulama Başlatıldı: http://localhost:${PORT}\n`);
});
