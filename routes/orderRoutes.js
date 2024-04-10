const express = require("express");
const validatePharmaisist = require("../middlewares/pharmacistHandler");
const validateToken = require("../middlewares/validateTokenHandler");
const { placeOrder,getOrdersByPharmacy,deleteOrderByID,changeOrderState } = require("../controllers/orderController");

const router = express.Router();

router.post("/place", validateToken, placeOrder);
// router.get('/allProducts',validateToken,getTotalProducts); // for patients
router.get('/allOrdersPharmacy',validateToken,validatePharmaisist,getOrdersByPharmacy); // for pharmacists
// router.get('/:id',validateToken,getPharmacyById);
router.delete('/delete/:id',validateToken,deleteOrderByID);
router.post('/status/:id',validateToken,validatePharmaisist,changeOrderState)

module.exports = router;
