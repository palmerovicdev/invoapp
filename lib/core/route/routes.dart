enum Routes {
  splash(path: '/splash', name: 'splash'),
  login(path: '/login', name: 'login'),
  home(path: '/home', name: 'home');

  final String path;
  final String name;

  const Routes({required this.path, required this.name});
}
