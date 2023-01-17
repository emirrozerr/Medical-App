const express = require("express");
const router = express.Router();
const users = require("./users");
const message = require("./message");

router.get("/", (req, res) => {
  res.send("FINAL PROJECT BACKEND SYSTEMS");
});
router.use("/users", users);
router.use("/message", message);

module.exports = router;
