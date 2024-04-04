const asyncHandler = require("express-async-handler");
const Product = require("../models/product");

//@desc add a product
//@route POST /api/product/add/
//@access private
const addProduct = asyncHandler(async(req,res)=>{
    const {
        name,
        description,
        price,
        category,
        stockQuantity,
        dosageForm, // Optional
        activeIngredients, // Optional
        manufacturer, // Optional
        expiryDate, // Optional
        images // Optional
    } = req.body;
    const requiredFiels = ["name","description","category","stockQuantity"];
    const missingFields = requiredFiels.filter(field => !req.body[field]);

    if (missingFields.length) {
        return res.status(400).json({success:false, message: `Missing required fields: ${missingFields.join(', ')}` });
    }

    try {
        const newProduct = await Product.create({
            name,
            description,
            price,
            category,
            stockQuantity,
            dosageForm,
            activeIngredients,
            manufacturer,
            expiryDate,
            images
        });

        res.status(201).json({success:true,message:"Product added successfully!",data:newProduct});
    } catch (error) {
        console.error("Failed to create product:", error);
        res.status(400).json({success:false, message: "Failed to create product" });
    }
});

//@desc update a product
//@route POST /api/product/update/:id
//@access private
const updateProduct = asyncHandler(async (req, res) => {
    const updates = req.body;
    const product = await Product.findById(req.params.id);
    if (!product) {
      return res
        .status(404)
        .json({ success: false, message: "Product not found." });
    }
  
    // Update each field with new values, if provided in the request
    for (let key in updates) {
      product[key] = updates[key];
    }
  
    await product.save();
    res
      .status(200)
      .json({
        success: true,
        message: "Product updated successfully!",
        data: product,
      });
  });
  
  //@desc delete a product
  //@route DELETE /api/product/delete/:id
  //@access private
  const deleteProduct= asyncHandler(async (req, res) => {
    const product = await Product.findById(req.params.id);
    if (!product) {
      return res
        .status(404)
        .json({ success: false, message: "Product not found." });
    }
  
    await product.remove();
    res
      .status(200)
      .json({ success: true, message: "Product deleted successfully." });
  });
  
  //@desc get all products
  //@route GET /api/product/get/
  //@access private
  const getAllProducts = asyncHandler(async (req, res) => {
    const products = Product.find();
    if (!products) {
      return res
        .status(404)
        .json({ success: false, message: "No products found!" });
    }
    return res
      .status(200)
      .json({ success: true, message: "Products retrived successfully!" });
  });
  
  //@desc get a product by id
  //@route GET /api/product/get/:id
  //@access private
  const getProductById = asyncHandler(async (req, res) => {
    const id = req.params.id;
    const product = Product.findOne({ _id: id });
    if (!product) {
      return res
        .status(404)
        .json({ sucess: false, message: `No Product found for ${id}` });
    }
    return res
      .status(200)
      .json({ success: true, message: "Product found!", data: product });
  });

  module.exports = {
    addProduct,
    updateProduct,
    deleteProduct,
    getAllProducts,
    getProductById
  }