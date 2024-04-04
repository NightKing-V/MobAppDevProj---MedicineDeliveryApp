const asyncHandler = require("express-async-handler");
const pharmacy = require("../models/pharmacy");

const validatePharmaisist = asyncHandler(async (req, res, next) => {
      const userID = req.user.id;
      const pharmacy = await pharmacy.findOne();
      if(!pharmacy){
        return res.status(403).json({message:"not a pharmacist"});
      }
      req.pharmacyID = pharmacy._id;
      next();
    });

module.exports = validatePharmaisist;
