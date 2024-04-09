const asyncHandler = require("express-async-handler");
const Pharmacy = require("../models/pharmacy");

//@desc Register a pharmacy
//@route POST /api/pharmacy/register
//@access private
const registerPharmacy = asyncHandler(async (req, res) => {

  const imagePath = req.file ? req.file.path : undefined;
  if(req.user.role != "pharmacist"){
    return res.status(403).json({success:false,message:"not a pharmacist"});
  }

  let address, geoLocation;
  try {
    address = JSON.parse(req.body.address);
    geoLocation = JSON.parse(req.body.geoLocation);
  } catch (e) {
    return res.status(400).json({ success: false, message: "Invalid address or geoLocation format." });
  }

  const { street, city, state, zipCode } = address;
  const { lat, lng } = geoLocation;

  const {
    pharmacyName,
    description,
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
    !imagePath ||
    !owner ||
    !licenseNumber ||
    !delivery 
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
  
  // Create pharmacy
  const newPharmacy = new Pharmacy({
    pharmacyName,
    description,
    address: { street, city, state, zipCode },
    geoLocation: { lat, lng },
    images: [imagePath],
    owner,
    ownerID: req.user.id,
    licenseNumber,
    delivery,
  });
  
  try {
    var savedPharmacy = await newPharmacy.save();
    savedPharmacy.images = savedPharmacy.images.map(image=>{
      const encodedPath = image.split('\\').map(encodeURIComponent).join('/');
      return process.env.FILE_HOST + encodedPath;
    } ) 
    res.status(201).json({ success: true, data: savedPharmacy });
  } catch (error) {
    res.status(400).json({ success: false, message: error.message });
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
