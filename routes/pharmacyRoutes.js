const express = require('express');
const { registerPharmacy } = require('../controllers/pharmacyController');
const { PhrmacyimageUpload } = require('../configs/uploadConfig');
const validatePharmaisist = require('../middlewares/pharmacistHandler');

const router = express.Router();

router.post('/register',validatePharmaisist, PhrmacyimageUpload.single('image'), registerPharmacy);

module.exports = router;
