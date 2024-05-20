# frozen_string_literal: true

Sentry.init do |config|
  # config.dsn = 'https://examplePublicKey@o0.ingest.sentry.io/0'

  # enable performance monitoring
  config.enable_tracing = 1.0

  # get breadcrumbs from logs
  config.breadcrumbs_logger = %i[active_support_logger http_logger]
end
