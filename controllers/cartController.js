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

        return res.status(200).json({success:true, message: "Product added to cart successfully", cart: cart });
    } catch (error) {
        console.error("Error adding product to cart:", error);
        return res.status(500).json({success:false, message: "An error occurred while adding the product to the cart." });
    }
});

//@desc get cart
//@route GET /api/cart/get
//@access private
const getCartByUser = asyncHandler(async(req, res) => {
    const userID = req.user.id;
    const carts = await Cart.find({ 'user': userID }).populate({
        path: 'items.product',
        model: 'Product',
       select: 'name price images pharmacyID _id'
    });

    if (!carts || carts.length === 0) {
        return res.status(404).json({ success: false, message: "No cart found for user" });
    }

    const baseURL = process.env.FILE_HOST;
    carts.forEach(cart => {
        cart.items.forEach(item => {
            item.product.images = item.product.images.map(imagePath => {
                let encodedPath = imagePath.split("\\").map(encodeURIComponent).join("/");
                let fullUrl = `${baseURL}/${encodedPath}`;
                fullUrl = fullUrl.replace(/([^:]\/)\/+/g, "$1");
                return fullUrl;
            });
        });
    });
    

    return res.status(200).json({ success: true, message: "Cart found", data: carts });
});

//@desc delete item from cart
//@route POST /api/cart/delete/:productid
//@access private
const deleteFromCart = asyncHandler(async (req, res) => {
    const prodcutID = req.params.id;
    const cart = await Cart.findOne({ "user": req.user.id });
    
    if (!cart) {
        return res.status(404).json({ success: false, message: "No cart found" });
    }
    
    try {
        const updatedCart = await Cart.updateOne(
          { "user": req.user.id },
          { $pull: { "items": { "product": prodcutID } } } // Assuming `product` directly stores the ObjectId
        );
    
        if (updatedCart.modifiedCount === 0) {
          return res.status(404).send('Product not found or already removed.');
        }
    
        return res.status(200).json({ success: true, message: 'Product removed successfully.', data: updatedCart });
    } catch (error) {
        console.error(error);
        return res.status(500).json({ success: false, message: 'An error occurred while removing the product.' });
    }
});



module.exports = {
    addToCart,
    getCartByUser,
    deleteFromCart
}