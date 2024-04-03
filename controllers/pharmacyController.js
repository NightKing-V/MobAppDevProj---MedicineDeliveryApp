const asyncHandler = require("express-async-handler");
const Pharmacy = require("../models/pharmacy");

//@desc Register a pharmacy
//@route POST /api/pharmacy/register
//@access private
const registerPharmacy = asyncHandler(async (req, res) => {
  const {
    pharmacyName,
    description,
    address: { street, city, state, zipCode },
    geoLocation: { lat, lng },
    images,
    owner,
    licenseNumber,
    delivery,
  } = req.body;

  if (
    !pharmacyName ||
    !description ||
    !street ||
    !city ||
    !state ||
    !zipCode ||
    !lat ||
    !lng ||
    !images ||
    !owner ||
    !licenseNumber ||
    delivery === undefined
  ) {
    return res
      .status(400)
      .json({ success: false, message: "Please provide all required fields." });
  }
  const existingPharmacy = await Pharmacy.findOne({ licenseNumber });
  if (existingPharmacy) {
    return res
      .status(400)
      .json({
        success: false,
        message: "Pharmacy with this license number already exists.",
      });
  }

  const pharmacy = await Pharmacy.create({
    pharmacyName,
    description,
    address: {
      street,
      city,
      state,
      zipCode,
    },
    geoLocation: {
      lat,
      lng,
    },
    images,
    owner,
    licenseNumber,
    delivery,
  });

  if (pharmacy) {
    res
      .status(201)
      .json({
        success: true,
        message: "Pharmacy created successfully",
        data: pharmacy,
      });
  } else {
    res
      .status(400)
      .json({ success: false, message: "Failed to create the pharmacy." });
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

//@desc get a pharmacy by id
//@route GET /api/pharmacy/get/
//@access private
const getAllPharmacies = asyncHandler(async (req, res) => {
  const pharmacies = Pharmacy.find();
  if (!pharmacies) {
    return res
      .status(404)
      .json({ success: false, message: "No pharmacies found!" });
  }
  return res
    .status(200)
    .json({ success: true, message: "Pharmacies retrived successfully!" });
});

//@desc get a pharmacy by id
//@route GET /api/pharmacy/get/:id
//@access private
const getPharmacyById = asyncHandler(async (req, res) => {
  const id = req.params.id;
  const pharmacy = Pharmacy.findOne({ _id: id });
  if (!pharmacy) {
    return res
      .status(404)
      .json({ sucess: false, message: `No pharmacy foind for ${id}` });
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
