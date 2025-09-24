import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  User? get currentUser => _auth.currentUser;
  String? get currentUserId => _auth.currentUser?.uid;
  
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserModel?> signInWithEmailAndPassword(
    String email, String password
    ) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
     User? user = result.user;
     if (user != null) {
      await _firestoreService.updateUserOnlineStatus(user.uid, true);
      return await _firestoreService.getUser(user.uid);
     } return null;
    } catch (e) {
      throw Exception('Failed to sign in');
    }
  }

  Future<UserModel?> registerWithEmailAndPassword(
   String email,
   String password,
   String displayName
    ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
     User? user = result.user;
     if (user != null) {
      await user.updateDisplayName(displayName);
      final userModel = UserModel(
        id: user.uid,
        email: email,
        displayName: displayName,
        photoURL: user.photoURL ?? '',
        isOnline: true,
        lastSeen: DateTime.now(),
        createdAt: DateTime.now(),
      );
      await _firestoreService.createUser(userModel);
      return userModel;
     } return null;
    } catch (e) {
      throw Exception('Failed to sign in');
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Failed to send password reset email');
    }
  }

  Future<void> signOut() async {
    try {
      if (currentUser != null) {
        await _firestoreService.updateUserOnlineStatus(currentUser!.uid, false);
      }
      await _auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out');
    }
  }

  Future<void> deleteAccount() async {
    try {
      User? user = currentUser;
      if (user != null) {
        await _firestoreService.deleteUser(user.uid);
        await user.delete();
      }
    } catch (e) {
      throw Exception('Failed to sign out');
    }
  }
}
