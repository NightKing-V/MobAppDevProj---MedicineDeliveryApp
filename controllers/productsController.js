const asyncHandler = require("express-async-handler");
const Product = require("../models/product");
const Pharmacy = require("../models/pharmacy");
const mongoose = require('mongoose');

//@desc add a product
//@route POST /api/product/add/
//@access private
const addProduct = asyncHandler(async (req, res) => {
  const imagePath = req.file ? req.file.path : undefined;
  const {
    name,
    description,
    price,
    category,
    stockQuantity,
    dosageForm,
    activeIngredients,
    manufacturer,
    expiryDate,
  } = req.body;
  const requiredFiels = ["name", "description", "category", "stockQuantity"];
  const missingFields = requiredFiels.filter((field) => !req.body[field]);

  if (missingFields.length) {
    return res
      .status(403)
      .json({
        success: false,
        message: `Missing required fields: ${missingFields.join(", ")}`,
      });
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
      images: imagePath,
      pharmacyID: req.user.pharmacyID,
    });
    newProduct.images = newProduct.images.map((image) => {
      const encodedPath = image.split("\\").map(encodeURIComponent).join("/");
      return process.env.FILE_HOST + encodedPath;
    });
    res
      .status(201)
      .json({
        success: true,
        message: "Product added successfully!",
        data: newProduct,
      });
  } catch (error) {
    console.error("Failed to create product:", error);
    res
      .status(402)
      .json({ success: false, message: "Failed to create product" });
  }
});

//@desc update a product
//@route PUT /api/product/update/:id
//@access private
const updateProduct = asyncHandler(async (req, res) => {
  const updates = req.body;
  const product = await Product.findById(req.params.id);
  if (!product) {
    return res
      .status(404)
      .json({ success: false, message: "Product not found." });
  }

  for (let key in updates) {
    product[key] = updates[key];
  }

  await product.save();
  res.status(200).json({
    success: true,
    message: "Product updated successfully!",
    data: product,
  });
});

//@desc delete a product
//@route DELETE /api/products/remove/:id
//@access private
const deleteProduct = asyncHandler(async (req, res) => {
  const productID = req.params.id;
  const product = await Product.findByIdAndDelete(productID);
  if (!product) {
    return res
      .status(404)
      .json({ success: false, message: "Product not found." });
  }
    return res
    .status(200)
    .json({ success: true, message: "Product deleted successfully." });
});

//@desc get all products by pharmacy
//@route GET /api/product/get/
//@access private
const getAllProducts = asyncHandler(async (req, res) => {

  const products = await Product.find({ pharmacyID: req.user.pharmacyID });
  products.map((product) => {
    product.images = product.images.map((image) => {
      const encodedPath = image.split("\\").map(encodeURIComponent).join("/");
      return process.env.FILE_HOST + encodedPath;
    });
    return product;
  });
  if (!products) {
    return res
      .status(404)
      .json({ success: false, message: "No products found!" });
  }
  return res
    .status(200)
    .json({ success: true, message: "Products retrived successfully!",data:products });
});

//@desc get all products
//@route GET /api/product/total/
//@access private
const getTotalProducts = asyncHandler(async (req, res) => {
  const products = await Product.find({});
  products.map((product) => {
    product.images = product.images.map((image) => {
      const encodedPath = image.split("\\").map(encodeURIComponent).join("/");
      return process.env.FILE_HOST + encodedPath;
    });
    return product;
  });
  if (!products) {
    return res
      .status(404)
      .json({ success: false, message: "No products found!" });
  }
  return res
    .status(200)
    .json({
      success: true,
      message: "Products retrived successfully!",
      data: products,
    });
});

//@desc get a product by id
//@route GET /api/product/get/:id
//@access private
const getProductById = asyncHandler(async (req, res) => {
  const id = req.params.id;
  if (!mongoose.isValidObjectId(id)) {
    return res.status(400).json({ success: false, message: `Invalid ID` });
  }
  const product = await Product.findOne({ _id: id });
  product.images = product.images.map((image) => {
    const encodedPath = image.split("\\").map(encodeURIComponent).join("/");
    return process.env.FILE_HOST + encodedPath;
  });
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
  getProductById,
  getTotalProducts,
};
