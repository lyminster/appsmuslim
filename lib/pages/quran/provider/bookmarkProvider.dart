import 'package:appsmuslim/helpers/bookmark_helpers.dart';
import 'package:appsmuslim/pages/quran/models/ayaModel.dart';
import 'package:appsmuslim/pages/quran/models/bookmarksModel.dart';
import 'package:appsmuslim/pages/quran/models/suraModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class BookmarkData extends ChangeNotifier {
  
  List<BookmarksModel> bookmarks = [];
  List<BookmarksModel> lastSeen = [];
  List<BookmarkFolder> bookmarksTable = [];
  
  bool isGettingData = true;

//GET FUNCTION
  getAllBookMarks() async {
    try{
      isGettingData = true;
      bookmarks = await BookmarksDataService().getListBookmarks();
      notifyListeners();
    }finally{
      isGettingData = false;
      notifyListeners();
    }
  }

  getAllLastSeen() async {
    try{
      isGettingData = true;
      lastSeen = await BookmarksDataService().getLast();
      notifyListeners();
    }finally{
      isGettingData = false;
      notifyListeners();
    }
  }

  Future<List<BookmarksModel>> getAllBookMarksdarifolder(String namaFolder) async {
    var bookmarks1;

    try{
      isGettingData = true;
      bookmarks1 = await BookmarksDataService().getListBookmarkswhere(namaFolder);
      notifyListeners();
    }finally{
      isGettingData = false;
      notifyListeners();
    }
    return bookmarks1;
  }

  getAllFolder() async {
    try{
      isGettingData = true;
      bookmarksTable = await BookmarksDataService().getListfolder();
      notifyListeners();
    }finally{
      isGettingData = false;
      notifyListeners();
    }
  }
      

//POST OR INSERT FUNNCTION
  Future<BookmarksModel> addLastSeen(
    Aya aya,
    Chapter chapter,
    String namaFolder,
    String jenis,
  ) async {
    var bookmarkModel = BookmarksModel()
      ..jenis = jenis
      ..aya = int.tryParse(aya.aya)
      ..insertTime = DateTime.now()
      ..sura = chapter.chapterNumber
      ..suraName = chapter.nameSimple
      ..namaFolder = namaFolder
      ..juzNumber = aya.juz;
    int id = await BookmarksDataService().addLast(bookmarkModel);
    notifyListeners();
    bookmarkModel.id = id;
    return bookmarkModel;
  }

  Future<BookmarksModel> addBookmark(
    Aya aya,
    Chapter chapter,
    String namaFolder,
    String jenis,
  ) async {
    var bookmarkModel = BookmarksModel()
      ..jenis = jenis
      ..aya = int.tryParse(aya.aya)
      ..insertTime = DateTime.now()
      ..sura = chapter.chapterNumber
      ..suraName = chapter.nameSimple
      ..namaFolder = namaFolder
      ..juzNumber = aya.juz;
    int id = await BookmarksDataService().add(bookmarkModel);
    notifyListeners();
    bookmarkModel.id = id;
    return bookmarkModel;
  }
  addFolder(String namaFolder) async {
    var bookmarkModel = BookmarkFolder()
    ..namaFolder = namaFolder
    ..insertTime = DateTime.now();
    int id = await BookmarksDataService().addnewfolder(bookmarkModel);
    getAllFolder();
  }

  //DELETE FUNCTION

  Future removeBookmark(
    int bookmarksModelId,
  ) async {
    await BookmarksDataService().delete(bookmarksModelId);
    notifyListeners();
  }

  Future removeFolder(
    int bookmarksModelId,
    String namaFolder
  ) async {
    await BookmarksDataService().deletefolder(bookmarksModelId,namaFolder);
    notifyListeners();
    await BookmarksDataService().deleteIsiFolder(namaFolder);
  }


   //UPDATE / PUT FUNCTION
  updateFolder(String namaFolder , int id) async {
    int did = await BookmarksDataService().updatefolder(namaFolder , id);
    getAllFolder();
  }
  

}