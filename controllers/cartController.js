const asyncHandler = require("express-async-handler");
const Cart = require("../models/cart");
const mongoose = require('mongoose');

//@desc add to cart
//@route POST /api/cart/add/:id
//@access private
const addToCart = asyncHandler(async (req, res) => {
    try {
        const userId = req.user.id;
        const { productID, quantity } = req.body;

        if (!productID || !quantity) {
            return res.status(400).json({success:false, message: "Product ID and quantity are required." });
        }
        let cart = await Cart.findOne({ user: userId });

        if (!cart) {
            cart = new Cart({
                user: userId,
                items: [{ product: productID, quantity }]
            });
        } else {
            const itemIndex = cart.items.findIndex(item => item.product.toString() === productID);

            if (itemIndex > -1) {
                cart.items[itemIndex].quantity += parseInt(quantity);
            } else {
                cart.items.push({ product: productID, quantity });
            }
        }
        await cart.save();

        res.status(200).json({success:true, message: "Product added to cart successfully", cart: cart });
    } catch (error) {
        console.error("Error adding product to cart:", error);
        res.status(500).json({success:false, message: "An error occurred while adding the product to the cart." });
    }
});

module.exports = {
    addToCart
}