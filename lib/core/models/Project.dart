class Project {
  String projectID;
  String projectHeader;

  Project(this.projectID,
      this.projectHeader); //Kategori eklerken kullan çünkü id dbden veriliyor

  @override
  String toString() {
    return 'Kategori{kategoriID: $projectID, kategoriBaslik: $projectHeader}';
  }
}
