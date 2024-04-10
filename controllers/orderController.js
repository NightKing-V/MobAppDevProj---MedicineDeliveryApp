const asyncHandler = require("express-async-handler");
const Order = require("../models/orders");
const mongoose = require('mongoose');

//@desc place a order
//@route POST /api/orders/place/
//@access private
const placeOrder = asyncHandler(async(req,res)=>{
    const {products, cost, shipping } = req.body;
    const userID = req.user.id;
    // Create a new order instance using the model
    const newOrder = new Order({
        userID,
        products,
        cost,
        shipping,
    });

    try {
        const savedOrder = await newOrder.save();
        res.status(201).json({success:true,message:"Order has been placed",data:savedOrder});
    } catch (error) {
        res.status(400).json({success:false, message: error.message });
    }
})

//@desc fetch orders by pharmacy
//@route GET /api/orders/getByPharmacy/
//@access private
const getOrdersByPharmacy = asyncHandler(async(req,res)=>{
    const pharmacyID = req.user.pharmacyID;
    console.log(pharmacyID)
    const orders = await Order.find({}) // Adjust based on your schema
          .populate({
              path: 'products',
              model: 'Product',
              select:'pharmacyID'
              // You can also filter the populated documents here, if necessary
          })
          .exec();
          
        
        res.status(200).json(orders);
})

module.exports = {
    placeOrder,
    getOrdersByPharmacy
}