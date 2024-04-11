const express = require("express");
const { ProductimageUpload } = require("../configs/uploadConfig");
const validatePharmaisist = require("../middlewares/pharmacistHandler");
const validateToken = require("../middlewares/validateTokenHandler");
const {
    addProduct,
    updateProduct,
    deleteProduct,
    getAllProducts,
    getProductById,
    getTotalProducts
  } = require('../controllers/productsController');

const router = express.Router();

router.post(
  "/add",
  validateToken,
  validatePharmaisist,
  ProductimageUpload.single("image"),
  addProduct
);
router.get('/allProducts',validateToken,getTotalProducts); // for patients
router.get('/allProductsPharmacy',validateToken,validatePharmaisist,getAllProducts); // for pharmacists
router.delete('/remove/:id',validateToken,deleteProduct);
// router.get('/:id',validateToken,getPharmacyById);

module.exports = router;
