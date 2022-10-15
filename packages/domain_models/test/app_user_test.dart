import 'package:domain_models/domain_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Testing AppUSer fromJson', () {
    final user = AppUser.fromJson({
      'name': 'username',
      'email': 'email',
      'photo': 'photo',
      'location': '1.0,2.0',
      'bio': 'bio',
      'upVote': 1,
      'downVote': 2,
      'visibility': true,
    },id: 'id');
    expect('id', 'id');
    expect(user.name, 'username');
    expect(user.email, 'email');
    expect(user.photo, 'photo');
    expect(user.location?.latitude, 1.0);
    expect(user.location?.longitude, 2.0);
    expect(user.bio, 'bio');
    expect(user.upVote, 1);
    expect(user.downVote, 2);
    expect(user.visibility, true);
  });

  test('Testing AppUser toJson', () {
    final user = AppUser(
      id: 'id',
      name: 'username',
      email: 'email',
      photo: 'photo',
      location: AppLocation(latitude: 1.0, longitude: 2.0),
      bio: 'bio',
      upVote: 1,
      downVote: 2,
      visibility: true,
    );
    expect(user.toJson(), {
      'id': 'id',
      'name': 'username',
      'email': 'email',
      'photo': 'photo',
      'location': '1.0,2.0',
      'bio': 'bio',
      'upVote': 1,
      'downVote': 2,
      'visibility': true,
    });
  });
}
