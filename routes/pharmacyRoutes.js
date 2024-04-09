const express = require("express");
const { registerPharmacy } = require("../controllers/pharmacyController");
const { PhrmacyimageUpload } = require("../configs/uploadConfig");
const validatePharmaisist = require("../middlewares/pharmacistHandler");
const validateToken = require("../middlewares/validateTokenHandler");

const router = express.Router();

router.post(
  "/register",
  validateToken,
  PhrmacyimageUpload.single("image"),
  registerPharmacy
);

module.exports = router;
