class Charity {
  final String name;
  final String assetName;

  Charity({required this.name, required this.assetName});
}

List<Charity> charities = [
  Charity(
    name: 'Plastic',
    assetName: 'assets/images/grad.png',
  ),
  Charity(
    name: 'Metal',
    assetName: 'assets/images/medic.png',
  ),
  Charity(
    name: 'Glass',
    assetName: 'assets/images/env.png',
  ),
  Charity(
    name: 'Branches',
    assetName: 'assets/images/animal.png',
  ),
  Charity(
    name: 'Gifts',
    assetName: 'assets/images/event.png',
  ),
];
