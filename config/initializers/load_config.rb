APP_CONFIG = YAML.load_file("#{Rails.root}/config/config.yml")[Rails.env]

BINANCE_API_KEY = APP_CONFIG.fetch('binance_api_key')
BINANCE_API_SECRET = APP_CONFIG.fetch('binance_api_secret')
BINANCE_API_BASE_ENDPOINT = APP_CONFIG.fetch('binance_api_base_endpoint')
