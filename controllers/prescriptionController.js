const asyncHandler = require("express-async-handler");
const mongoose = require("mongoose");
const prescription = require("../models/prescription");

//@desc place a prescription
//@route POST /api/prescriptions/place/
//@access private

const addPrescription = asyncHandler(async (req, res) => {
  const userID = req.user.id;
  const imagePath = req.file ? req.file.path : undefined;
  try {
    const newPrescription = await prescription.create({
      userID,
      prescriptionImage: imagePath,
    });
    return res.status(201).json({
      success: true,
      message: "prescription uplaoded",
      data: newPrescription,
    });
  } catch (error) {
    return res
      .status(400)
      .json({ success: false, message: "failed to add prescription" });
  }
});

//@desc get all prescriptions
//@route GET /api/prescriptions/getAll/
//@access private

const getPrescriptions = asyncHandler(async (req, res) => {
  try {
    // Fetch all prescriptions from the database
    const prescriptions = await prescription.find({}).populate({
      path: "userID",
      model: "User",
    });

    if (!prescriptions || prescriptions.length === 0) {
      return res
        .status(404)
        .json({ success: false, message: "No prescriptions found" });
    }


    const baseURL = process.env.FILE_HOST;
    const updatedData = prescriptions.map((item) => {
      const encodedPath = item.prescriptionImage
        .split("\\")
        .map(encodeURIComponent)
        .join("/");
      item.prescriptionImage = `${baseURL}${encodedPath}`;
      return item; 
    });

    return res.status(200).json({
      success: true,
      message: "Prescriptions retrieved",
      data: updatedData,
    });
  } catch (error) {
    console.error("Error retrieving prescriptions:", error); // Log the error for more detailed debugging
    return res.status(400).json({
      success: false,
      message: "Failed to retrieve prescriptions",
    });
  }
});

//@desc get prescription by id
//@route GET /api/prescriptions/get/:id
//@access private

const getPrescription = asyncHandler(async (req, res) => {
  try {
    const prescriptions = await prescription.findById(req.params.id);
    return res.status(201).json({
      success: true,
      message: "prescriptions retrived",
      data: prescriptions,
    });
  } catch (error) {
    return res
      .status(400)
      .json({ success: false, message: "failed to retrive prescriptions" });
  }
});

//@desc get all prescriptions by user
//@route GET /api/prescriptions/get/
//@access private

const getPrescriptionsByUser = asyncHandler(async (req, res) => {
  try {
    const prescriptions = await prescription.find({ userID: req.user.id }).populate({
      path: "userID",
      model: "User",
    });

    const baseURL = process.env.FILE_HOST;

    const updatedData = prescriptions.map((item) => {
      const encodedPath = item.prescriptionImage
        .split("\\")
        .map(encodeURIComponent)
        .join("/");
      item.prescriptionImage = `${baseURL}${encodedPath}`;
      return item;
    });
    return res.status(200).json({
      success: true,
      message: "prescriptions retrived",
      data: updatedData,
    });
  } catch (error) {
    return res
      .status(400)
      .json({ success: false, message: "failed to retrive prescriptions" });
  }
});

//@desc delete prescriptions by id
//@route DELETE /api/prescriptions/delete/:id
//@access private
const deletePrescriptionById = asyncHandler(async(req,res)=>{
    const presID = req.params.id;
    const deleteDoc = await prescription.findByIdAndDelete(presID);
    if(!deleteDoc){
        return res.status(404).json({success:false,message:"No prescription found"});
    }
    return res.status(200).json({success:true,message:"Prescription Deleted",data:deleteDoc});
});

//@desc update prescription delivery status
//@route POST /api/prescriptions/status/:id
//@access private
const updatePrescriptionById = asyncHandler(async (req, res) => {
    const presID = req.params.id;
    const pharmacyName = req.user.pharmacyName;

    // Find the prescription document by ID
    const prescriptionDoc = await prescription.findById(presID);
    if (!prescriptionDoc) {
        return res.status(404).json({ success: false, message: "No prescription found" });
    }

    // Update the 'pickedup' status of the prescription
    prescriptionDoc.pickedup = `Accepted By ${pharmacyName}`;

    const updatedPrescription = await prescriptionDoc.save();

    return res.status(200).json({
        success: true,
        message: "Prescription status updated successfully",
        data: updatedPrescription
    });
});

//@desc get prescriptions accepted by pharmacy
//@route GET /api/prescriptions/getPharmacy/
//@access private
const getPrescriptionByPharmacy = asyncHandler(async (req, res) => {
    const pharmacyName = req.user.pharmacyName;
    try {
        const regex = new RegExp(`Accepted By ${pharmacyName}`, 'i');
        const prescriptions = await prescription.find({ pickedup: regex }).populate({
            path: "userID",
            model: "User",
          });
          const baseURL = process.env.FILE_HOST;
          const updatedData = prescriptions.map((item) => {
            const encodedPath = item.prescriptionImage
              .split("\\")
              .map(encodeURIComponent)
              .join("/");
            item.prescriptionImage = `${baseURL}${encodedPath}`;
            return item;
          });
        return res.status(200).json({ success: true, data: updatedData });
    } catch (error) {
        console.error('Error fetching prescriptions:', error);
        res.status(500).json({ success: false, message: error.message });
    }
});


module.exports = {
  addPrescription,
  getPrescriptions,
  getPrescription,
  getPrescriptionsByUser,
  deletePrescriptionById,
  updatePrescriptionById,
  getPrescriptionByPharmacy
};
