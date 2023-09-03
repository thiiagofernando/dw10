enum Menu {
  paymentType(
    '/payment-type/',
    'payment_type_ico.png',
    'payment_type_ico_selected.png',
    'Formas de Pagamento',
  ),

  products(
    '/products/',
    'product_ico.png',
    'product_ico_selected.png',
    'Produtos',
  ),
  orders(
    '/order/',
    'order_ico.png',
    'order_ico_selected.png',
    'Pedidos do Dia',
  );

  final String route;
  final String assetIcon;
  final String assetIconSelected;
  final String label;

  const Menu(this.route, this.assetIcon, this.assetIconSelected, this.label);
  static Menu? findByPatch(String patch) {
    final menu = Menu.values.where((element) => patch.contains(element.route));
    if (menu.isNotEmpty) {
      return menu.first;
    }
    return null;
  }
}
