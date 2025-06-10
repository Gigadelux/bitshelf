import 'package:bitshelf/controllers/BookController.dart';
import 'package:bitshelf/data/models/Book.dart';
import 'package:bitshelf/services/BookDatasetService.dart';
import 'package:bitshelf/view/ui/pages/BookPages/AddBookPage.dart';
import 'package:bitshelf/view/ui/pages/BookPages/EditBookPage.dart';
import 'package:bitshelf/view/ui/widgets/bookTable.dart';
import 'package:bitshelf/view/ui/widgets/drawers/DrawerTree.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bitshelf/view/ui/widgets/drawers/drawerValues.dart' as drawerV;

class Bookpage extends StatefulWidget {
  const Bookpage({super.key});

  @override
  State<Bookpage> createState() => _BookpageState();
}

class _BookpageState extends State<Bookpage> with AutomaticKeepAliveClientMixin{

  Bookcontroller bookcontroller = Bookcontroller();
  String drawer = drawerV.values.keys.first; //default

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final dataset = Provider.of<BookDatasetService>(context); //subscribe
    List<Book> booksData = dataset.books;
    return Scaffold(
      endDrawer: DrawerTree(operation: drawer),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Manage Books", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 35),),
                  Row(
                    children: [
                      MaterialButton(
                        color: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> AddBookPage())),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              Text("Add book")
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      MaterialButton(
                        color: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onPressed: ()async{
                          await bookcontroller.load_books();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Icon(Icons.upload),
                              Text("load books")
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                        MaterialButton(
                        onPressed: (){},
                        color: const Color.fromARGB(255, 0, 94, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.download, color: Colors.white,),
                              Text("Export", style: TextStyle(color: Colors.white),)
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    ),
                    width: MediaQuery.of(context).size.width/2.5,
                    child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search books",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      prefixIcon: Icon(Icons.search),
                    ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Builder(
                    builder: (context) => IconButton(
                      onPressed: () {
                        setState(() => drawer = drawerV.values.keys.elementAt(0));
                        Scaffold.of(context).openEndDrawer();
                      },
                      icon: Icon(Icons.tune, color: const Color.fromARGB(255, 0, 94, 255), size: 30),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Builder(
                    builder: (context) => IconButton(
                      onPressed: () {
                        setState(() => drawer = drawerV.values.keys.elementAt(1));
                        Scaffold.of(context).openEndDrawer();
                      },
                      icon: Icon(Icons.commit_rounded, color: const Color.fromARGB(255, 0, 94, 255), size: 30),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Booktable(books: booksData, 
              onActionPressed: (book)=> Navigator.push(context, MaterialPageRoute(builder: (context)=>EditBookPage(book: book,))),
            )
          ],
        ),
      ),
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}