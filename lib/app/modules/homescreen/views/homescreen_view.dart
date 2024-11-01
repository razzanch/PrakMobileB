import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/app/modules/create_task_screen/views/create_task_screen_view.dart';
import 'package:myapp/app/modules/widgetbackground/views/appcolor.dart';
import 'package:myapp/app/modules/widgetbackground/views/widgetbackground_view.dart';

class HomescreenView extends StatefulWidget {
  @override
  _HomescreenViewState createState() => _HomescreenViewState();
}

class _HomescreenViewState extends State<HomescreenView> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Appcolor appColor = Appcolor();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double widthScreen = mediaQueryData.size.width;
    double heightScreen = mediaQueryData.size.height;

    return Scaffold(
      backgroundColor: appColor.colorPrimary,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            WidgetbackgroundView(),
            _buildWidgetListTodo(widthScreen, heightScreen, context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          bool? result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateTaskScreenView(isEdit: false),
            ),
          );
          if (result != null && result) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Task has been created')),
            );
            setState(() {});
          }
        },
        backgroundColor: appColor.colorTertiary,
      ),
    );
  }

  Container _buildWidgetListTodo(
      double widthScreen, double heightScreen, BuildContext context) {
    return Container(
      width: widthScreen,
      height: heightScreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: Text(
              'Todo List',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore.collection('tasks').orderBy('date').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    Map<String, dynamic> task = document.data() as Map<String, dynamic>;
                    String strDate = task['date'];

                    return Card(
                      child: ListTile(
                        title: Text(task['name']),
                        subtitle: Text(
                          task['description'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        isThreeLine: false,
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 24.0,
                              height: 24.0,
                              decoration: BoxDecoration(
                                color: appColor.colorSecondary,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${int.parse(strDate.split(' ')[0])}',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              strDate.split(' ')[1],
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<String>(
                                value: 'edit',
                                child: Text('Edit'),
                              ),
                              PopupMenuItem<String>(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ];
                          },
                          onSelected: (String value) async {
  if (value == 'edit') {
    // Navigasi ke halaman CreateTaskScreenView untuk edit task
    bool? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateTaskScreenView(
          isEdit: true,
          documentId: document.id,  // Mengirimkan documentId untuk task yang sedang diedit
          name: task['name'],        // Mengirimkan nama task yang ada
          description: task['description'], // Mengirimkan deskripsi task yang ada
          date: task['date'],        // Mengirimkan tanggal task yang ada
        ),
      ),
    );

    // Menampilkan pesan jika task telah diperbarui
    if (result != null && result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task has been updated')),
      );
      setState(() {}); // Update tampilan setelah edit
    }
  } else if (value == 'delete') {
    // Konfirmasi sebelum menghapus task
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Task"),
          content: Text("Are you sure you want to delete this task?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(false); // Tutup dialog tanpa menghapus
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () {
                Navigator.of(context).pop(true); // Tutup dialog dan konfirmasi penghapusan
              },
            ),
          ],
        );
      },
    );

    if (confirmDelete) {
      // Hapus task dari Firestore
      await firestore.collection('tasks').doc(document.id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task has been deleted')),
      );
      setState(() {}); // Update tampilan setelah penghapusan
    }
  }
},

                          child: Icon(Icons.more_vert),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
