import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotel_app/pages/login_or_register.dart';
import 'package:hotel_app/settings/change_theme.dart';
import 'package:hotel_app/widgets/card_news.dart';
import 'package:hotel_app/widgets/search_field.dart';
import '../models/news_model.dart';
import '../providers/news_provider.dart'; // Assuming the provider is here

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;

    // Sign out method
    void signUserOut() async {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Check if the user is signed in with Google
        if (user.providerData
            .any((provider) => provider.providerId == 'google.com')) {
          // Sign out from Firebase and Google
          await FirebaseAuth.instance.signOut();
          await GoogleSignIn().signOut();
          print('Signed out from Google');
        } else {
          // Sign out from Firebase (email/password)
          await FirebaseAuth.instance.signOut();
          print('Signed out from Email/Password');
        }
      }

      // Make sure the session is cleared and navigate to login/register page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const LoginOrRegister()), // Go to Login/Registration page
      );
    }

    NewsModel news = ref.watch(newsProvider).newsModel;
    bool isLoading = ref.watch(newsProvider).isLoading;

    return Scaffold(
      backgroundColor: const Color(0xffF8F9FD),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ChangeTheme()),
              );
            },
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SearchField(),
            isLoading
                ? SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: news.articles!.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return NewsCard(article: news.articles![index]);
                      },
                    ),
                  ),
            user != null
                ? Center(child: Text("Logged in as: ${user.email!}" , style : const TextStyle(color :Colors.black)))
                : const Center(child: Text("No user is logged in")),
          ],
        ),
      ),
    );
  }
}
