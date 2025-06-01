import 'package:bitshelf/view/ui/widgets/bookTable.dart';
import 'package:flutter/material.dart';

class Bookpage extends StatefulWidget {
  const Bookpage({super.key});

  @override
  State<Bookpage> createState() => _BookpageState();
}

class _BookpageState extends State<Bookpage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
                        onPressed: (){},
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
                  child: IconButton(onPressed: (){}, icon: Icon(Icons.tune,color: const Color.fromARGB(255, 0, 94, 255), size: 30,)),
                ),
              ],
            ),
            SizedBox(height: 30,),
            Booktable(books: [], onActionPressed: (book){})
          ],
        ),
      ),
    );
  }
}