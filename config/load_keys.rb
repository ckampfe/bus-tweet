keyfile = YAML.load_file(CONFIG.join('', 'keys.yml'))

keyfile.each do |key_name, key|
  ENV[key_name] = key
end
