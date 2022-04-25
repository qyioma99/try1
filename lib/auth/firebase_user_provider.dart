import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Try1FirebaseUser {
  Try1FirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

Try1FirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Try1FirebaseUser> try1FirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<Try1FirebaseUser>((user) => currentUser = Try1FirebaseUser(user));
