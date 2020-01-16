module Exceptions
  # Parent of all API errors
  class ApiError < StandardError; end

  # Error raised when email is not found
  class EmailNotFound < ApiError; end
  # Error raised when password is not found
  class InvalidPassword < ApiError; end
end
