import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  static const initial_route = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 100),
                  color: const Color.fromARGB(255, 1, 12, 70),
                  child: Column(
                    children: [
                       const SizedBox(
                          height: 100,
                          width: 100,
                          child: CircleAvatar(
                           backgroundImage: AssetImage('assets/ui.jpg'),
                          ),
                       ),
                       Container(
                        margin: const EdgeInsets.only(top: 50),
                         child: const Text(
                    'Rextor Movie merupakan adalah layanan streaming yang didedikasikan untuk menayangkan film-film hit mancanegara dan lokal terbesar, semuanya di satu tempat',maxLines: 5,
                    style: TextStyle(color: Color.fromARGB(221, 250, 247, 247), fontSize: 20),
                    textAlign: TextAlign.justify,
                  ),
                       ),
              
                    ],
                    
                  ),
                ),
              ),
              
            ],
          ),
          SafeArea(
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios),
            ),
          )
        ],
      ),
    );
  }
}
