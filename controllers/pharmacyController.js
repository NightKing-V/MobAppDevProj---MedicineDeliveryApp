const asyncHandler = require("express-async-handler");
const Pharmacy = require("../models/pharmacy");
const mongoose = require('mongoose');

//@desc Register a pharmacy
//@route POST /api/pharmacy/register
//@access private
const registerPharmacy = asyncHandler(async (req, res) => {
  try {
    const { pharmacyName, description, address, owner, licenseNumber, delivery } = req.body;
    console.log(req.body)
    // Check if required fields are provided
    if (!pharmacyName || !description || !address || !owner || !licenseNumber || !delivery) {
      return res.status(400).json({ success: false, message: "Missing required fields." });
    }

    // Create a new pharmacy object using the Pharmacy model
    const newPharmacy = new Pharmacy({
      pharmacyName,
      description,
      address,
      owner,
      ownerID: req.user.id,
      licenseNumber,
      delivery,
    });

    // Save the pharmacy to the database
    const savedPharmacy = await newPharmacy.save();
    res.status(201).json({ success: true, data: savedPharmacy });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
});


//@desc update a pharmacy
//@route POST /api/pharmacy/update/:id
//@access private
const updatePharmacy = asyncHandler(async (req, res) => {
  const updates = req.body;

  const pharmacy = await Pharmacy.findById(req.params.id);
  if (!pharmacy) {
    return res
      .status(404)
      .json({ success: false, message: "Pharmacy not found." });
  }

  // Update each field with new values, if provided in the request
  for (let key in updates) {
    pharmacy[key] = updates[key];
  }

  await pharmacy.save();
  res
    .status(200)
    .json({
      success: true,
      message: "Pharmacy updated successfully!",
      data: pharmacy,
    });
});

//@desc delete a pharmacy
//@route DELETE /api/pharmacy/delete/:id
//@access private
const deletePharmacy = asyncHandler(async (req, res) => {
  const pharmacy = await Pharmacy.findById(req.params.id);
  if (!pharmacy) {
    return res
      .status(404)
      .json({ success: false, message: "Pharmacy not found." });
  }

  await pharmacy.remove();
  res
    .status(200)
    .json({ success: true, message: "Pharmacy deleted successfully." });
});

//@desc get all pharmacies
//@route GET /api/pharmacy/get/
//@access private
const getAllPharmacies = asyncHandler(async (req, res) => {
  const pharmacies = await Pharmacy.find();
  if (!pharmacies) {
    return res
      .status(404)
      .json({ success: false, message: "No pharmacies found!" });
  }
  return res
    .status(200)
    .json({ success: true, message: "Pharmacies retrived successfully!", data:pharmacies });
});

//@desc get a pharmacy by id
//@route GET /api/pharmacy/get/:id
//@access private
const getPharmacyById = asyncHandler(async (req, res) => {
  const id = req.params.id;
  if (!mongoose.isValidObjectId(id)) {
    return res.status(400).json({ success: false, message: `Invalid ID` });
  }
  const pharmacy = await Pharmacy.findOne({ _id: id });
  if (!pharmacy) {
    return res
      .status(404)
      .json({ sucess: false, message: `No pharmacy found for ${id}` });
  }
  return res
    .status(200)
    .json({ success: true, message: "Pharmacy found!", data: pharmacy });
});

module.exports = {
  registerPharmacy,
  updatePharmacy,
  deletePharmacy,
  getAllPharmacies,
  getPharmacyById,
};
