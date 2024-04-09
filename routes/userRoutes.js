const express = require('express');
const {
    registerUser,
    loginUser,
    updateUser,
    deleteUser,
    allPharmacists,
    allPatients,
    currentUser
} = require('../controllers/userController')
const validatePharmaisist = require('../middlewares/pharmacistHandler');
const validateToken = require("../middlewares/validateTokenHandler")
const authorize = require('../middlewares/authorizeHandler')

const router = express.Router();

router.post('/register', registerUser);
router.post('/login', loginUser);
router.put('/update',validateToken,updateUser);
router.delete('/delete',validateToken,deleteUser);
router.get('/getAllPharmacists',validateToken,allPharmacists);
router.get('/getAllPatients',validateToken,allPatients);
router.get('/current',validateToken,currentUser);

module.exports = router;
