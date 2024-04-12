const multer = require('multer');
const path = require('path');

const PharmacyimageStorage = multer.diskStorage({
    // Destination to store image     
    destination: 'uploads/Pharmacy/', 
    filename: (req, file, cb) => {
        cb(null, file.fieldname + '_' + Date.now() 
           + path.extname(file.originalname));
    }
});

const ProductimageStorage = multer.diskStorage({
    // Destination to store image     
    destination: 'uploads/Product/', 
    filename: (req, file, cb) => {
        cb(null, file.fieldname + '_' + Date.now() 
           + path.extname(file.originalname));
    }
});

const PrescriptionimageStorage = multer.diskStorage({
    // Destination to store image     
    destination: 'uploads/Prescription/', 
    filename: (req, file, cb) => {
        cb(null, file.fieldname + '_' + Date.now() 
           + path.extname(file.originalname));
    }
});

const PhrmacyimageUpload = multer({
    storage: PharmacyimageStorage,
    limits: {
      fileSize: 1000000 // 1000000 Bytes = 1 MB
    },
    fileFilter(req, file, cb) {
        if (!file.originalname.match(/\.(png|jpg|jpeg)$/)) { 
           // upload only png and jpg format
           return cb(new Error('Please upload a Image'))
         }
       cb(undefined, true)
    }
});

const ProductimageUpload = multer({
    storage: ProductimageStorage,
    limits: {
      fileSize: 1000000 // 1000000 Bytes = 1 MB
    },
    fileFilter(req, file, cb) {
        if (!file.originalname.match(/\.(png|jpg|jpeg)$/)) { 
           // upload only png and jpg format
           return cb(new Error('Please upload a Image'))
         }
       cb(undefined, true)
    }
});

const PrescriptionimageUpload = multer({
    storage: PrescriptionimageStorage,
    limits: {
      fileSize: 1000000 // 1000000 Bytes = 1 MB
    },
    fileFilter(req, file, cb) {
        if (!file.originalname.match(/\.(png|jpg|jpeg)$/)) { 
           // upload only png and jpg format
           return cb(new Error('Please upload a Image'))
         }
       cb(undefined, true)
    }
});

module.exports = { PhrmacyimageUpload, ProductimageUpload, PrescriptionimageUpload };
