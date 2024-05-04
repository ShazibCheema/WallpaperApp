class CategoryModel{
  String categoryName;
  String categoryImgUrl;

  CategoryModel({required this.categoryImgUrl, required this.categoryName});

  static CategoryModel fromApi2App(Map<String, dynamic> category){
    return CategoryModel(categoryImgUrl: category["imgUrl"],
        categoryName: category["CategoryName"]);
  }
}