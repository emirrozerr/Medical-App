const express = require("express");
const router = express.Router();
const {
  emailCheck,
  passwordCheck,
  nameAndSurnameCheck,
} = require("../helpers/validations/validations");
const {
  register,
  login,
  getUser,
  uploadImage,
  getDoctor,
  getDoctorA,
  getDoctorB,
  getMajorList,
  registerDoctor
} = require("../controllers/users");

router.get("/", (req, res) => {
  res.send("FINAL PROJECT BACKEND SYSTEMS");
});
router.post("/registerDoctor", emailCheck,
  passwordCheck,
  nameAndSurnameCheck, registerDoctor);
router.post(
  "/register",
  emailCheck,
  passwordCheck,
  nameAndSurnameCheck,
  register
);

router.post("/login", passwordCheck, emailCheck, login);
router.post("/getUser", getUser);
router.post("/uploadImage", uploadImage);
router.get("/getDoctor/:uname", getDoctor);
router.get("/getDoctorA/:id", getDoctorA);
router.get("/getDoctorB/:id", getDoctorB);
router.get("/getMajorList", getMajorList);

module.exports = router;
