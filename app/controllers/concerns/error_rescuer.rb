module ErrorRescuer
  extend ActiveSupport::Concern

  # Global error setup for response JSON of the API
  def error!(message, error_code, status, details = {})
    json = { message: message, error_code: error_code }
    json[:details] = details unless details.empty?
    render json: json, status: status
  end

  included do
    rescue_from StandardError,                  with: :unmatched_error

    rescue_from Exceptions::EmailNotFound,      with: :email_not_found
    rescue_from Exceptions::InvalidPassword,    with: :invalid_password
    rescue_from Exceptions::InvalidToken        with: :invalid_token

    rescue_from Exceptions::UserNotFound,       with: :user_not_found
    rescue_from Exceptions::UserMovieNotFound,  with: :user_movie_not_found
  end

  # Unmatch cas of error raised
  def unmatched_error(e)
    logger.error("Unexpected error occured")
    logger.error(e)
    logger.error(e.backtrace.join("\n"))
    error!("Une erreur a été trouvée", e.class.name, 500, message: e.message)
  end

  # error when email is not found
  def email_not_found(e)
    error!("Email not found", e.class.name, 404)
  end

  # error when password is not found
  def invalid_password(e)
    error!("Password invalid", e.class.name, 404)
  end
    
  # error when user's movie is not found
  def invalid_token(e)
    error!("Token is invalid", e.class.name, 404)
  end

  # error when user is not found
  def user_not_found(e)
    error!("User not found", e.class.name, 404)
  end

  # error when user's movie is not found
  def user_movie_not_found(e)
    error!("User movie not found", e.class.name, 404)
  end

end
