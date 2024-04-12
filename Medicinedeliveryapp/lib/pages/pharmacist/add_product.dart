import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:medicinedeliveryapp/controllers/pharmacist_products.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Add Form', // Set app title
      theme: ThemeData(
        primarySwatch: Colors.blue, // Set app theme (optional)
      ),
      home: AddProduct(),
    );
  }
}

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key

  Future<void> uploadProductData() async {
  if (_formKey.currentState!.validate() && _imageFile != null) {
    // Assuming uploadProduct is defined according to the previous explanation
    await uploadProduct(
      context: context,
      name: _nameController.text,
      description: _descriptionController.text,
      price: _priceController.text,
      category: _categoryController.text,
      stockQuantity: _stockQuantityController.text,
      dosageForm: _dosageFormController.text,
      activeIngredients: _activeIngredientsController.text,
      manufacturer: _manufactureController.text,
      expiryDate: _expiryDateController.text,
      imageFile: File(_imageFile!.path),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Product submitted successfully')),
    );
  } else {
  
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please pick an image for the product')),
    );
  }
}

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _stockQuantityController = TextEditingController();
  final TextEditingController _dosageFormController = TextEditingController();
  final TextEditingController _activeIngredientsController = TextEditingController();
  final TextEditingController _manufactureController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();


  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  Future<void> _getImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
             
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
                            TextFormField(
                controller: _stockQuantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Stock Quantity',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter stock quantity';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _dosageFormController,
                decoration: InputDecoration(
                  labelText: 'Dosage Form',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the dosage form';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _activeIngredientsController,
                decoration: InputDecoration(
                  labelText: 'Active Ingredients',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter active ingredients';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _manufactureController,
                decoration: InputDecoration(
                  labelText: 'Manufacturer',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter manufacturer';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _expiryDateController,
                decoration: InputDecoration(
                  labelText: 'Expiry Date (yyyy-MM-dd)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter expiry date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
           
              if (_imageFile != null)
                Image.file(
                  File(_imageFile!.path),
                  height: 150,
                ),
              const SizedBox(height: 10.0),
             Row(
              children: [
                 ElevatedButton(
                onPressed: _getImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: 
                  Icon(Icons.photo_camera,color: Colors.white,),
              ),
              SizedBox(width: 10,),
              Text("Choose an image",style: TextStyle(fontWeight: FontWeight.bold),)
              ],
             ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                 uploadProductData(); 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text('Add Product',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
