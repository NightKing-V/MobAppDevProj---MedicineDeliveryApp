const express = require("express");
const validatePharmaisist = require("../middlewares/pharmacistHandler");
const validateToken = require("../middlewares/validateTokenHandler");
const {
  addPrescription,
  getPrescriptions,
  getPrescription,
  getPrescriptionsByUser,
  deletePrescriptionById,
  updatePrescriptionById,
  getPrescriptionByPharmacy
} = require("../controllers/prescriptionController");
const { PrescriptionimageUpload } = require("../configs/uploadConfig");

const router = express.Router();

router.post(
  "/place",
  validateToken,
  PrescriptionimageUpload.single("image"),
  addPrescription
);
router.get("/getAll", validateToken, validatePharmaisist, getPrescriptions);
router.get("/get", validateToken, getPrescriptionsByUser);
router.get("/get/:id", validateToken, getPrescription);
router.delete("/delete/:id", validateToken, deletePrescriptionById);
router.post("/status/:id", validateToken, validatePharmaisist, updatePrescriptionById);
router.get("/getPharmacy", validateToken, validatePharmaisist, getPrescriptionByPharmacy);

module.exports = router;
