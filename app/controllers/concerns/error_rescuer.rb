module ErrorRescuer
  extend ActiveSupport::Concern

  def error!(message, error_code, status, details = {})
    json = { message: message, error_code: error_code }
    json[:details] = details unless details.empty?
    render json: json, status: status
  end

  included do
    rescue_from StandardError,                          with: :unmatched_error
    rescue_from Exceptions::EmailNotFound,              with: :email_not_found
    rescue_from Exceptions::InvalidPassword,            with: :invalid_password
  end

  def unmatched_error(e)
    logger.error("Unexpected error occured")
    logger.error(e)
    logger.error(e.backtrace.join("\n"))
    error!("Une erreur a été trouvée", e.class.name, 500, message: e.message)
  end

  def email_not_found(e)
    error!("Email not found", e.class.name, 404)
  end

  def invalid_password(e)
    error!("Password invalid", e.class.name, 404)
  end
end
