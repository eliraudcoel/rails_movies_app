module ErrorRescuer
  extend ActiveSupport::Concern

  def error!(message, error_code, status, details = {})
    json = { message: message, error_code: error_code }
    json[:details] = details unless details.empty?
    render json: json, status: status
  end

  included do
    rescue_from StandardError,                          with: :unmatched_error
    rescue_from ActiveRecord::RecordInvalid,            with: :invalid_record
    rescue_from ActiveRecord::RecordNotFound,           with: :record_not_found
    rescue_from Exceptions::InvalidToken,               with: :invalid_token
    rescue_from Exceptions::InvalidUser,                with: :invalid_user
    rescue_from Exceptions::AuthenticationRequired,     with: :authentication_required
    rescue_from Exceptions::MissingParameter,           with: :missing_parameter
  end

  def unmatched_error(e)
    logger.error("Unexpected error occured")
    logger.error(e)
    logger.error(e.backtrace.join("\n"))
    error!("Une erreur a été trouvée", e.class.name, 500, message: e.message)
  end

  def invalid_record(e)
    record = e.record
    logger.error("error_message=\"#{e.message}\" invalid_record=\"#{record.inspect}\"")
    logger.error(e)
    logger.error(e.backtrace.join("\n"))
    message = record.errors.full_messages.join("\n")
    error!(message, e.class.name, 422)
  end

  def record_not_found(error)
    model = model_name(error)
    message = I18n.t "record_not_found",
      model_name: model,
      scope: %i(activerecord exceptions)
    error!(message, error.class.name, 404)
  end

  def invalid_token(e)
    error!("Authentification incorrecte", e.class.name, 401)
  end

  def invalid_user(e)
    error!("User incorrect", e.class.name, 401)
  end

  def authentication_required(e)
    error!("Merci de s'authentifier", e.class.name, 403)
  end

  def missing_parameter(e)
    error!("Paramêtre manquant", e.class.name, 400)
  end
end
