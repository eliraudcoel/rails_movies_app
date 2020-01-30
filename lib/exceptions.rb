module Exceptions
  # Parent of all API errors
  class ApiError < StandardError; end
  #
  # SESSIONS
  #

  # Error raised when email is not found
  class EmailNotFound < ApiError; end
  # Error raised when password is not found
  class InvalidPassword < ApiError; end
  # Error raised when token is invalid
  class InvalidToken < ApiError; end


  #
  # USERS
  #

  # Error raised when user is not found
  class UserNotFound < ApiError; end
end
