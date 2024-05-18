import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../utils/formatters/formatters.dart';

/// Model class representing user data
class UserModel {
  // Keep those value final which don't want to update
  final String id;
  String firstName;
  String lastName;
  final String userName;
  final String email;
  String phoneNumber;
  String profilePicture;

  /// Constructor for UserModel
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  /// Helper function to get the full name.
  String get fullName => "$firstName $lastName";

  /// helper function to format phone number
  String get formattedPhoneNo => SFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to split full name into first and last name
  static List<String> namePart(fullName) => fullName.split(" ");

  /// Static function to generate a username from the full name
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUserName =
        "$firstName$lastName"; // Combine first and last name
    String userNameWithPrefix = 'cwt_$camelCaseUserName'; // Add "cwt_" prefix
    return userNameWithPrefix;
  }

  // Static function to create an empty user model
  static UserModel empty() => UserModel(
      id: '',
      firstName: '',
      lastName: '',
      userName: '',
      email: '',
      phoneNumber: '',
      profilePicture: ''
  );

  /// Convert model to JSON structure for storing data in Firebase;
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': userName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        userName: data['UserName'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      throw Exception('Document snapshot data is null');
    }
  }


}
