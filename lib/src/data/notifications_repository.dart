import '../models/api_error_model.dart';
import '../models/notifications_new_update.dart';
import 'api_provider.dart';
import 'user_repository.dart';

abstract class NotificationsRepository {
  Future<NotificationsNewUpdate> getUnreadNotificationsCount();
}

class NotificationsRepositoryImpl extends ApiProvider implements NotificationsRepository {
  final UserRepository _userRepository = UserRepositoryImpl();
  
  @override
  Future<NotificationsNewUpdate> getUnreadNotificationsCount() async {
    try {
      if ( await _userRepository.hasToken() ) {
        final String token = await _userRepository.getToken();

        final response = await this.get(
          path: 'api/rest/notifications/new-updates',
          queryParameters: {
            'oauth_token': token
          }
        );

        if ( response['error'] == true ) {
          throw response;
        }

        return NotificationsNewUpdate.fromJson(response);
      }

      throw ApiError(
        error: true,
        errorCode: "authorization",
        message: "Unauthenticated user, please login to get the notifications count",
        statusCode: 401
      );
    } catch (e) {
      throw e;
    }
  }

}