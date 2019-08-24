APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]

BINANCE_API_KEY = APP_CONFIG.fetch('binance_api_key')
BINANCE_SECRET_KEY = APP_CONFIG.fetch('binance_secret_key')
