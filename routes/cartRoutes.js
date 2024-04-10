const express = require("express");
const validatePharmaisist = require("../middlewares/pharmacistHandler");
const validateToken = require("../middlewares/validateTokenHandler");
const { addToCart } = require("../controllers/cartController");

const router = express.Router();

router.post("/add", validateToken, addToCart);

module.exports = router;
