const asyncHandler = require("express-async-handler");
const pharmacy = require("../models/pharmacy");

const validatePharmaisist = asyncHandler(async (req, res, next) => {
      const userID = req.user.id;
      const _pharmacy = await pharmacy.findOne({ownerID:userID});
      if(!_pharmacy){
        return res.status(403).json({message:"not a pharmacist"});
      }
      req.pharmacyID = _pharmacy._id;
      req.pharmacyName = _pharmacy.pharmacyName;
      next();
    });

module.exports = validatePharmaisist;
