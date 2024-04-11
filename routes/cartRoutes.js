const express = require("express");
const validatePharmaisist = require("../middlewares/pharmacistHandler");
const validateToken = require("../middlewares/validateTokenHandler");
const { addToCart, getCartByUser, deleteFromCart } = require("../controllers/cartController");

const router = express.Router();

router.post("/add", validateToken, addToCart);
router.get("/get", validateToken, getCartByUser);
router.delete("/remove/:id", validateToken, deleteFromCart);

module.exports = router;
