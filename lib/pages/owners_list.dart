import 'package:flutter/material.dart';
import '../components/menu.dart';
import '../data/data.dart';
import '../utils/locales.dart';
import '../widgets/dynamic_background.dart';
import 'register_pet.dart';
import '../models/owner.dart';

class OwnersListPage extends StatelessWidget {
  const OwnersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Data.getOwners(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                color: Colors.white,
                child: const LinearProgressIndicator(
                    backgroundColor: Colors.black));
          } else if (snapshot.hasError) {
            return Container(
                color: Colors.white,
                child: Center(
                    child: Text(
                  "Lo sentimos. Inténtelo de nuevo.",
                  style: Theme.of(context).textTheme.headlineMedium,
                )));
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text(ListOwnerStrings.ownersList),
              ),
              drawer: const Menu(),
              body: DynamicBackground(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    final owner = Owner.fromMap(snapshot.data[index]);
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5.0,
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(15.0),
                        title: Text(owner.name,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ID: ${owner.identificacion}'),
                            Text('Dirección: ${owner.address}'),
                            Text('Teléfono: ${owner.phone}'),
                            Text('Correo Electrónico: ${owner.email}'),
                          ],
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPetPage(
                                    ownerId: owner.identificacion.toString()),
                              ),
                            );
                          },
                          child: const Text(ListOwnerStrings.addPet),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        });
  }
}
