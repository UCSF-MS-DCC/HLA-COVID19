Recaptcha.configure do |config|
  config.site_key = Rails.application.credentials.dig(:recaptcha_site_key)#ENV["RECAPTCHA_PUBLIC_KEY"] #Rails.application.secrets[:RECAPTCHA_SITE_KEY]
  config.secret_key = Rails.application.credentials.dig(:recaptcha_secret_key)#ENV["RECAPTCHA_PRIVATE_KEY"] #Rails.application.secrets[:RECAPTCHA_PRIVATE_KEY]
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
end