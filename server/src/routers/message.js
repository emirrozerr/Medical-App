const express = require("express");
const { getUserAllMessage, sendMessage,messageDetails } = require("../controllers/messages");
const router = express.Router();

router.post("/getUserAllMessage", getUserAllMessage);
router.post("/sendMessage", sendMessage);
router.post("/messageDetails", messageDetails);
module.exports = router;
