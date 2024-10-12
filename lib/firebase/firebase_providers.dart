import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for accessing Cloud Firestore instance.
final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);

/// Provider for accessing Firebase Authentication instance.
final authProvider = Provider((ref) => FirebaseAuth.instance);


