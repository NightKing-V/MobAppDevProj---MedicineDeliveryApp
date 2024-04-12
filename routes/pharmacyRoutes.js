const express = require("express");
const { registerPharmacy, getAllPharmacies, getPharmacyById } = require("../controllers/pharmacyController");
const { PhrmacyimageUpload } = require("../configs/uploadConfig");
const validatePharmaisist = require("../middlewares/pharmacistHandler");
const validateToken = require("../middlewares/validateTokenHandler");

const router = express.Router();

// router.post(
//   "/register",
//   validateToken,
//   PhrmacyimageUpload.single("image"),
//   registerPharmacy
// );
router.post(
  "/register",
  validateToken,
  registerPharmacy
);

router.get('/all',validateToken,getAllPharmacies);
router.get('/:id',validateToken,getPharmacyById);

module.exports = router;
