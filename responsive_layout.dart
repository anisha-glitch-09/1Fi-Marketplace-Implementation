// The current grid is: crossAxisCount: 2
// For a phone that's good.
// For tablets:
// You guys can use this:
final width =
    MediaQuery.of(context).size.width;
final columns = width > 700 ? 3 : 2;

// Then try this also in your production:
SliverGrid(
  gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: columns,
    crossAxisSpacing: 12,
    mainAxisSpacing: 14,
    childAspectRatio: 0.67,
  ),
)
