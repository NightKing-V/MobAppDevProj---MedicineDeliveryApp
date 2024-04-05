const PurchaseHistory = require('../models/PurchaseHistory'); // Adjust the path as necessary

//@desc add to history
//@route POST /api/productHistory/add/
//@access private
const createPurchaseHistory = asyncHandler(async (req, res) => {
    const { userID, productID } = req.body;

    if (!userID || !productID) {
        return res.status(400).json({success:false, message: 'userID and productID are required' });
    }

    const purchaseHistory = new PurchaseHistory({
        userID,
        productID
    });

    await purchaseHistory.save();
    res.status(201).json({success:true,message:"Product added to history",data:purchaseHistory});
});

//@desc get all history
//@route GET /api/productHistory/get/
//@access private
const getAllPurchaseHistories = asyncHandler(async (req, res) => {
    const userId = req.user.id;

    const purchaseHistories = await PurchaseHistory.find({ userID: userId })
        .populate('userID')
        .populate('productID');

    if (!purchaseHistories) {
        return res.status(404).json({success: false, message: "No purchase history found for the user" });
    }

    res.status(200).json({success: true, message: "Purchase history retrieved successfully", data: purchaseHistories });
});

//@desc get history by id
//@route GET /api/productHistory/get/:id
//@access private
const getPurchaseHistoryById = asyncHandler(async (req, res) => {
    const { id } = req.params;

    const purchaseHistory = await PurchaseHistory.findById(id).populate('userID').populate('productID');

    if (!purchaseHistory) {
        return res.status(404).json({success:false, message: 'Purchase history not found' });
    }

    res.status(200).json({success:true,message:`history for ${id}`,data:purchaseHistory});
});

//@desc delete history by id
//@route DELETE /api/productHistory/delete/:id
//@access private
const deletePurchaseHistory = asyncHandler(async (req, res) => {
    const { id } = req.params;

    const purchaseHistory = await PurchaseHistory.findByIdAndDelete(id);

    if (!purchaseHistory) {
        return res.status(404).json({success:false, message: 'Purchase history not found' });
    }
    res.status(200).json({success:true, message: 'Purchase history deleted successfully' });
});
