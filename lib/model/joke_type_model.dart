class JokeType {
  String name;
  String value;
  JokeType({required this.name, required this.value});
}

final List<JokeType> jokeTypes = [
  JokeType(name: 'Programming', value: 'Programming'),
  JokeType(name: 'Pun', value: 'pun'),
  JokeType(name: 'Misc', value: 'Miscellaneous'),
  JokeType(name: 'Dark', value: 'Dark'),
  JokeType(name: 'Spooky', value: 'Spooky'),
  JokeType(name: 'Christmas', value: 'Christmas')
];
