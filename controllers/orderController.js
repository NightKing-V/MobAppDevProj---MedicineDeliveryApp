const asyncHandler = require("express-async-handler");
const Order = require("../models/orders");
const mongoose = require('mongoose');

//@desc place a order
//@route POST /api/orders/place/
//@access private
const placeOrder = asyncHandler(async(req,res)=>{
    const {product, qty, cost, shipping } = req.body;
    const userID = req.user.id;
    // Create a new order instance using the model
    const newOrder = new Order({
        userID,
        product,
        cost,
        qty,
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
const getOrdersByPharmacy = asyncHandler(async (req, res) => {
    const pharmacyID = req.user.pharmacyID;
    let orders = await Order.find({})
        .populate({
            path: 'product', // Ensure this is the correct path
            model: 'Product',
            select: 'pharmacyID' // This will only select pharmacyID in the populated data
        }).populate({
            path:'userID',
            model:'User',
            select:'firstName',
        });

    const filteredOrders = orders.filter(order => 
        order.product && order.product.pharmacyID.toString() === pharmacyID.toString()
    );
    
    res.status(200).json({success:true,message:"orders fetched successfully!",data:filteredOrders});
});

//@desc delete orders by id
//@route GET /api/orders/delete/:id
//@access private
const deleteOrderByID = asyncHandler(async(req,res)=>{
    const recordID = req.params.id;
    const deletedDoc = await Order.findByIdAndDelete(recordID);
    if(!deletedDoc){
        return res.status(403).json({success:false,message:"No order found!"});
    }
    return res.status(200).json({success:true,message:"Order deleted !"});
})

const changeOrderState = asyncHandler(async(req,res)=>{
    const recordID = req.params.id;
    const {status} = req.body;
    console.log("ji")
    try {
        const updatedDoc = await Order.findByIdAndUpdate(
            recordID,
          { $set: { status: status } }, // Update operation
          { new: true } // Options: return the modified document rather than the original. defaults to false
        );
    
        if (updatedDoc) {
          return res.status(200).json({success:true,message:"order status updated",data:updatedDoc})
        } else {
            return res.status(400).json({success:false,message:"failed to update order status"})

        }
      } catch (error) {
        return res.status(400).json({success:false,message:"failed to update order status"})
      }
})
module.exports = {
    placeOrder,
    getOrdersByPharmacy,
    deleteOrderByID,
    changeOrderState
}