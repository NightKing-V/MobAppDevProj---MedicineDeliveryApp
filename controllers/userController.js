const bcrypt = require("bcryptjs");
const asyncHandler = require("express-async-handler");
const jwt = require("jsonwebtoken");
const User = require("../models/user");

//@desc Register a user
//@route POST /api/users/register
//@access public
const registerUser = asyncHandler(async (req, res) => {
    const { firstName, lastName, address, nic, contactNo, email, username, password, role } = req.body;
    if (!firstName || !lastName || !address || !nic || !contactNo || !email || !username || !password) {
        return res.status(400).json({message:"All fields are mandatory!"});
    }
    const userAvailable = await User.findOne({ email });
    if (userAvailable) {
        return res.status(400).json({success:false,message:"User already registerd"});
    }
    // hashing password
    const hashedPassword = await bcrypt.hash(password, 10);
    const user = await User.create({
        firstName,
        lastName,
        address,
        nic,
        contactNo,
        email,
        username,
        password: hashedPassword,
        role,
    });

    if (user) {
        return res.status(201).json({success:true, _id: user.id, email: user.email });
    } else {
        return res.status(400).json({success:false,message:"User data is not valid"});
    }
});

//@desc Login user
//@route POST /api/users/login
//@access public
const loginUser = asyncHandler(async (req, res) => {
    const { username, password } = req.body;

    // Validate input
    if (!username || !password) {
        return res.status(400).json({success:false, message: "Username and password are required." });
    }

    // Attempt to find the user by username
    const user = await User.findOne({ username });
    if (!user) {
        // Security best practice: use generic error messages
        return res.status(401).json({success:false, message: "Invalid credentials." });
    }

    // Verify password
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
        // Security best practice: use generic error messages
        return res.status(401).json({success:false, message: "Invalid credentials." });
    }

    // Generate JWT
    try {
        const accessToken = jwt.sign({
            id: user.id,
            username: user.username,
            role: user.role,
        }, process.env.ACCESS_TOKEN_SECRET, { expiresIn: '30m' });

        // Return success response
        return res.status(200).json({
            success: true,
            id: user.id,
            username: user.username,
            accessToken: accessToken
        });
    } catch (error) {
        console.error("JWT Error:", error);
        return res.status(500).json({success:false, message: "Failed to generate access token." });
    }
});

//@desc Update user
//@route PUT /api/users/update
//@access private
const updateUser = asyncHandler(async (req,res)=>{
    const id = req.params.id;
    const user = await User.findById(id);
    if(!user){
        return res.status(404).json({success:false,message:`User not found with ${id}`});
    }
    if(user.id.toString() !== req.user.id){
        return res.status(403).json({success:false,message:"User don't have permission to update other users"});
    }
    const updatedUser = await User.findByIdAndUpdate(
        id,
        req.body,
        {new: true}
    );
    return res.status(200).json({success:true,message:"User updated successfully", id:updatedUser.id, email:updatedUser.email});
})

//@desc Delete user
//@route DELETE /api/users/delete
//@access private
const deleteUser = asyncHandler(async (req, res) => {
    const id = req.params.id
    const user = await User.findById(id);
    if(!user){
        return res.status(404).json({message:"User not found"});
    }
    await User.deleteOne({_id: id});
    return res.status(200).json({message:"User deleted successfully", data:user});
});

//@desc Get all Pharmacists
//@route GET /api/users/pharmacists
//@access private
const allPharmacists = asyncHandler(async(req,res) => {
    const users = await User.find({'role':'pharmacist'});
    if(!users){
        return res.status(404).json({success:false,message:"Pharmacists Not Found!"});
    }
    return res.status(200).json({success:true,message:"Pharmacists Retrived Successfully",data:users});
});

//@desc Get all Patients
//@route GET /api/users/patients
//@access private
const allPatients = asyncHandler(async(req,res) => {
    const users = await User.find({'role':'patient'});
    if(!users){
        return res.status(404).json({success:false,message:"Patients Not Found!"});
    }
    return res.status(200).json({success:true,message:"Patients Retrived Successfully",data:users});
});

//@desc Get all Patients
//@route GET /api/users/current
//@access private
const currentUser = asyncHandler(async(req,res) => {
    const id = req.user.id;
    const user = await User.findById(id);
    if(!user){
        return res.status(404).json({success:false,message:"User Not Found!"});
    }
    return res.status(200).json({success:true,message:"User Retrived Successfully",data:user});
});

module.exports = {
    registerUser,
    loginUser,
    updateUser,
    deleteUser,
    allPharmacists,
    allPatients,
    currentUser
}