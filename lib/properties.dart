import 'package:yaml/yaml.dart';
import 'package:flutter/services.dart' show rootBundle;

class Property {
  final String name;
  final String value;

  static final Map<String, Property> _cache = new Map<String, Property>();

  factory Property(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name];
    }
    return new Property._internal(name, null);
  }

  Property._internal(this.name, this.value);

  static init() async {
    String yaml = await rootBundle.loadString('config/config.yaml');
    Map appConfig = loadYaml(yaml);
    Map properties = appConfig['app']['properties'];
    properties.forEach(
        (key, value) => _cache[key] = new Property._internal(key, value));
  }
}
