
data = YAML.load_file "config/settings.yml"

data["version"]['date'] = Date.today

puts data['version']['date']

File.open("config/settings.yml", 'w') { |f| YAML.dump(data, f) }