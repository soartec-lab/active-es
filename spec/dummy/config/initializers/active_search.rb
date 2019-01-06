config = YAML.load_file(Rails.root.join('config', 'searchengine.yml'))
Rails.application.config.searchengine = config[Rails.env]
