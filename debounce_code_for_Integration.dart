import 'dart:async';
TextField(
  onChanged: onSearchChanged,
)
Timer? _searchTimer;

void onSearchChanged(String value) {
  _searchTimer?.cancel();

  _searchTimer = Timer(
    const Duration(milliseconds: 500),
    () {
      provider.search(value);
    },
  );
}
