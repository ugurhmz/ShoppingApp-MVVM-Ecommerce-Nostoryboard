//
//  AddProductsVC.swift
//  ShoppingAdmin
//
//  Created by ugur-pc on 29.05.2022.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class AddProductsVC: UIViewController {
    
    var homeViewModel = HomeViewModel()
    var allCategories: [CategoryModel]? = []
    var lastIndexActive:IndexPath = [1 ,0]
    var myBool: Bool = false
    let scrollView = UIScrollView()
    var selectCategoryBool = false
    var selectedPrdCategoryString: String = ""
    
    var prdname = ""
    var prdprice = 0.0
    var prddesc = ""
    var prdstock = "0"
    
    private let prdTitleField: CustomTextField = {
        let txt = CustomTextField(padding: 24, height: 55)
        txt.backgroundColor = .white
        txt.attributedPlaceholder = NSAttributedString(string:"Product title...", attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font :UIFont(name: "Arial", size: 20)!])
        txt.textColor = .black
        txt.layer.borderWidth = 1
        return txt
    }()
    private let prdPriceField: CustomTextField = {
        let txt = CustomTextField(padding: 24, height: 55)
        txt.backgroundColor = .white
        txt.attributedPlaceholder = NSAttributedString(string:"Product price...", attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font :UIFont(name: "Arial", size: 20)!])
        txt.textColor = .black
        txt.layer.borderWidth = 1
        return txt
    }()
    
    private let prdStockField: CustomTextField = {
        let txt = CustomTextField(padding: 24, height: 55)
        txt.backgroundColor = .white
        txt.attributedPlaceholder = NSAttributedString(string:"Product stock...", attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font :UIFont(name: "Arial", size: 20)!])
        txt.textColor = .black
        txt.layer.borderWidth = 1
        return txt
    }()
    
    
    private let selectCategory: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        cv.backgroundColor = .white
        cv.register(SelectCategoryCell.self,
                    forCellWithReuseIdentifier: SelectCategoryCell.identifier)
        return cv
    }()
  
    
    private let prdDescriptionText: UITextView = {
           let tv = UITextView()
           tv.font = .systemFont(ofSize: 20)
           tv.textAlignment = .left
           tv.backgroundColor = .white
           tv.layer.cornerRadius = 12
           tv.isEditable = true
           tv.textColor = .black
           tv.layer.borderWidth = 1
           return tv
       }()
 
    private let prdImgView: UIImageView = {
         let iv = UIImageView()
         iv.image = UIImage(named: "addphoto")
         iv.contentMode = .scaleAspectFill
         iv.clipsToBounds = true
         iv.layer.cornerRadius = 15
         return iv
    }()
    
    private let addBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Add Product", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 15
        btn.backgroundColor = AppColors.DarkGreen
        btn.layer.borderWidth = 1
        btn.layer.borderColor = AppColors.DarkGreen.cgColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        btn.addTarget(self, action: #selector(addPrdClickHandle), for: .touchUpInside)
        return btn
    }()
    
   
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [prdTitleField, prdPriceField, prdStockField,selectCategory, prdDescriptionText, prdImgView, addBtn])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        homeViewModel.fetchAllCategoriesData()
        
        self.homeViewModel.reloadData = { [weak self] in
            guard let self = self else {return }
            self.allCategories = self.homeViewModel.categoryList
            self.selectCategory.reloadData()
           
        }
    }
}

//MARK: - Delegate, DataSource
extension AddProductsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allCategories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectCategoryCell.identifier, for: indexPath) as! SelectCategoryCell
        
        cell.data(data: self.allCategories?[indexPath.row] ?? CategoryModel(data: [:]))
        cell.layer.cornerRadius = 20
        cell.backgroundColor = .lightGray.withAlphaComponent(0.8)
        
        
        return cell
    }
 
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

       if self.lastIndexActive != indexPath {
       let cell = collectionView.cellForItem(at: indexPath) as! SelectCategoryCell
       cell.configure(select: true)
           print()
           
           if let selectedCate = self.allCategories?[indexPath.item].id {
               self.selectCategoryBool = true
               self.selectedPrdCategoryString = selectedCate
               print("click")
           }
           
       let cell1 = collectionView.cellForItem(at: self.lastIndexActive) as? SelectCategoryCell
           cell1?.configure(select: false)
       self.lastIndexActive = indexPath
          
       }
   }
}

//MARK: -
extension AddProductsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            return CGSize(width: (view.frame.width / 3) - 16 ,
                          height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
    }
}

 //MARK: - IMAGE PICKER
extension AddProductsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func launchImagePicker() {
        let imagePicker  = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }

        prdImgView.contentMode = .scaleAspectFill
        prdImgView.image = image
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}


//MARK: -
extension AddProductsVC {
    
    private func setupViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.setCustomSpacing(15, after: prdDescriptionText)
        stackView.setCustomSpacing(15, after: prdImgView)
        
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        selectCategory.delegate = self
        selectCategory.dataSource = self
        
        
        let imgSelectTap = UITapGestureRecognizer(target: self, action: #selector(selectPrdImage))
        imgSelectTap.numberOfTapsRequired = 1 // Kullan??c??n??n el hareketinin tespit edilmesi i??in gereken dokunma say??s??. (Varsay??lan de??eri 1'dir.)
        prdImgView.isUserInteractionEnabled = true
        prdImgView.addGestureRecognizer(imgSelectTap)
    }
    
    @objc func selectPrdImage(){
        launchImagePicker()
    }
    
    @objc func addPrdClickHandle(){
        uploadImageAndDocument()
    }
    
    func uploadImageAndDocument(){
        if !selectCategoryBool {
            createAlert(title: "Missing Fields",
                        msg: "Please fill required fields.",
                        prefStyle: .alert,
                        bgColor: .white,
                        textColor: .red,
                        fontSize: 25)
            return
        }
        
        guard let prdImg = prdImgView.image,
              let prdName = prdTitleField.text, !prdName.isEmpty,
              let prdStock = prdStockField.text, !prdStock.isEmpty,
              let prdDesc = prdDescriptionText.text, !prdDesc.isEmpty,
              let prdPrice = prdPriceField.text,
              let price = Double(prdPrice) else {
                  createAlert(title: "Missing Fields",
                              msg: "Please fill required fields.",
                              prefStyle: .alert,
                              bgColor: .white,
                              textColor: .red,
                              fontSize: 25)
                  return
              }
        
        self.prdname = prdName
        self.prddesc = prdDesc
        self.prdprice = price
        self.prdstock = prdStock
        
        
        showActivityIndicator()
        
        guard let imageData = prdImg.jpegData(compressionQuality: 0.2) else { return }
        let imageRef = Storage.storage().reference().child("/productImages/\(prdName).jgp")
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        imageRef.putData(imageData, metadata: metaData) { (metaData, error) in
            if let error = error {
                self.createAlert(title: "\(error.localizedDescription)",
                            msg: "image upload error!",
                            prefStyle: .alert,
                            bgColor: .white, textColor: .red, fontSize: 26)
                return
            }
            
            imageRef.downloadURL { (url, error) in
                if let error = error {
                    self.createAlert(title: "\(error)",
                                msg: "Image Download err!", prefStyle: .alert, bgColor: .white, textColor: .red, fontSize: 28)
                    return
                }
                
                guard let url = url else { return }
                print("myimage", url)
                self.uploadPrdDocument(url: url.absoluteString)
            }
        }
    }
    
    func uploadPrdDocument(url: String){
        var docRef: DocumentReference?
        var willSavePrd = ProductModel(id: "",
                                       name: prdname,
                                       category: selectedPrdCategoryString,
                                       price: prdprice,
                                       productOverview: prddesc,
                                       imageUrl: url,
                                       timeStamp: Timestamp(),
                                       stock: Int(prdstock) ?? 0)
        
        docRef = Firestore.firestore().collection("products").document()
        willSavePrd.id = docRef?.documentID ?? ""
        
        let data = ProductModel.modelToData(product: willSavePrd)
        docRef?.setData(data, merge: true, completion: {  error in
            if let error = error {
                self.createAlert(title: "Error",
                                 msg: "Fail upload new category to Firestore",
                                 prefStyle: .alert,
                                 bgColor: .white, textColor:  #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), fontSize: 24)
                print("err",error.localizedDescription)
                self.hideActivityIndicator()
                return
            }
           

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                self.hideActivityIndicator()
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
}

//MARK: - CONSTRAINTS
extension AddProductsVC {
    private func setConstraints(){
        
      
        scrollView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          leading: view.leadingAnchor,
                          bottom: view.bottomAnchor,
                          trailing: view.trailingAnchor,
                          padding: .init(top: 0, left: 0, bottom: 0, right: 0)
        )
        
         
        prdTitleField.anchor(top: nil,
                             leading: nil,
                             bottom: nil,
                             trailing: nil,
                             size: .init(width: 0, height: 55))
        
        prdPriceField.anchor(top: nil,
                             leading: nil,
                             bottom: nil,
                             trailing: nil,
                             size: .init(width: 0, height: 55))
        
        prdStockField.anchor(top: nil,
                             leading: nil,
                             bottom: nil,
                             trailing: nil,
                             size: .init(width: 0, height: 55))
        
        selectCategory.anchor(top: nil,
                              leading: nil,
                              bottom: nil,
                              trailing: nil,
                              size: .init(width: 0, height:105))
        
        prdDescriptionText.anchor(top: nil,
                             leading: nil,
                             bottom: nil,
                             trailing: nil,
                             size: .init(width: 0, height: 200))
        
        stackView.anchor(top: scrollView.topAnchor,
                         leading: view.leadingAnchor,
                         bottom: scrollView.bottomAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 23, left: 0, bottom: 25, right: 0) )
       
        
        prdImgView.anchor(top: nil,
                          leading: nil,
                          bottom: nil,
                          trailing: nil,
                          size: .init(width: 100, height: 260))
        
        addBtn.anchor(top: nil,
                      leading: nil,
                      bottom: nil,
                      trailing: nil,
                      size: .init(width: 0, height: 50))
    }
}


