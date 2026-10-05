// lab3.dart - Campus Cafe Order System
// Name: _____Raja Hasham Ahmed_______ Roll no:04072313006
const String rollNo = '04072313006'; // e.g. '04072313006'
// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit
const List<String> menu = [
 'Chai', 'Latte', 'Mocha', 'Samosa', 'Brownie',
 'Sandwich', 'Cold Coffee', 'Fries', 'Pakora', 'Zinger Wrap',
];
int priceOf(int i) => 100 + 7 * i + 3 * t; // price of menu[i], in rupees
final int priceFloor = 60 + 5 * t;
final int taxPercent = 5 + t;
final int bigOrderLimit = 450 + 20 * t;
final int balanceCap = 600 + 20 * t;
final int couponPercent = 5 + t + u;
// ===========================================================================

//TASK: 1
class Dish {
  late String name;
  late int price;
}

//TASK : 2
class MenuItem {
  String name;
  
  int price;
//price cannot be considered as ::final because the constructor may change it to priceFloor.
  MenuItem(this.name, this.price) {
    
    if (this.price < priceFloor) {
      this.price = priceFloor;
    }
  }
  //TASK 3.1 construtorr.

    MenuItem.free(this.name) : price = 0;
    //TASK 3.2::
     MenuItem.fromString(String text) : name = text.split(':')[0],
        price = int.parse(text.split(':')[1]);
//STEP :8::
        @override
String toString() => '$name (Rs $price)';
}
//TASK 10:::::->
class Coupon {
  static final Map<String, Coupon> _cache = {};

  final String code;
  final int percent;
  final int minSpend;

  Coupon(this.code, this.percent)
      : minSpend = percent * 70,
        assert(
          percent >= 1 && percent <= 50,
          'percent must be between 1 and 50',
        );

  factory Coupon.fromCode(String code) {
    return _cache.putIfAbsent(
      code,
      () => Coupon(code, couponPercent),
    );
  }

  int discountOn(int amount) {
    if (amount >= minSpend) {
      return amount * percent ~/ 100;
    }

    return 0;
  }
}


//PART 08
List<MenuItem> buildMenu() {
  return [
    for (int k = 0; k < 4; k++)
      MenuItem.fromString(
        '${menu[(u + 3 * k) % 10]}:${priceOf((u + 3 * k) % 10)}',
      ),
  ];
}

//TASK :: 09
List<OrderLine> buildReceipt() {
  List<MenuItem> items = buildMenu();

  return [
    for (int k = 0; k < 3; k++)
      OrderLine(
        items[k],
        1 + (t + k) % 4,
      ),
  ];
}


//STEP ::04:
class OrderLog {
    //Underscore makes them library private in Dart.
// If not using it.. other code could directly access  _instance or _internal and bypass the singleton's controlled creation.
  static OrderLog? _instance;
  final List<String> entries = [];

  OrderLog._internal();

  factory OrderLog() {
    return _instance ??= OrderLog._internal();
  }

  void add(String msg) => entries.add(msg);
}

//5..1

class OrderLine {
  final MenuItem item;
  final int qty;
  final int total;
  final int tax;

  OrderLine(this.item, this.qty)
      : total = item.price * qty,
        tax = (item.price * qty) * taxPercent ~/ 100,
        assert(qty > 0, 'qty must be positive');

  // The initializer list cannot read another field of the same object because instance fields are initialized at the same time use the constructor parameter ->item) instead.
 
 //STEP :: 6.1
   int get grand => total + tax;

bool get isBigOrder => grand > bigOrderLimit;

String get label => '${item.name} x$qty';

}

//5.2:

OrderLine mainOrder() {
  return OrderLine(
    MenuItem(menu[u], priceOf(u)),
    2 + (t + u) % 5,
  );
}

//task:: 07:
class StudentCard {
  final String owner;
  int _balance;

  StudentCard(this.owner) : _balance = 0;

  int get balance => _balance;

  set balance(int v) {
    if (v < 0) {
      _balance = 0;
    } else if (v > balanceCap) {
      _balance = balanceCap;
    } else {
      _balance = v;
    }
  }
// Another option for an invalid value would be to throw an exception instead of silently clamping it.
}


void main() {
 print('Seed: $seed (t=$t, u=$u)');
 step1();
 step2();
 step3();
 step4();
 step5();
 step6();
 step7();
 step8();
 step9();
 step10();
}
void step1() {
  Dish item1 = Dish();
  item1.name = menu[u];
  item1.price = priceOf(u);

  Dish item2 = Dish();
  int index2 = (u + 1) % 10;
  item2.name = menu[index2];
  item2.price = priceOf(index2);

  item2.price = item2.price - u;

  print('Step 1: ${item1.name} Rs ${item1.price}');
  print('Step 1: ${item2.name} Rs ${item2.price}');
}
void step2() {
  MenuItem a = MenuItem(menu[u], priceOf(u));
  MenuItem b = MenuItem('Test Special', 15 * u);

  print('Step 2: ${a.name} Rs ${a.price}');
  print('Step 2: ${b.name} Rs ${b.price}');
}

void step3() {
    // free() is a separate named constructor so it does not run  normal MenuItem constructorr body containing the floor logic.
  MenuItem freebie = MenuItem.free('Water');

  int i = (u + 2) % 10;
  MenuItem parsed =
      MenuItem.fromString('${menu[i]}:${priceOf(i)}');

  print('Step 3: ${freebie.name} Rs ${freebie.price}');
  print('Step 3: ${parsed.name} Rs ${parsed.price}');
  print('Step 3: floor=$priceFloor, free price=${freebie.price}');
}
void step4() {
  OrderLog log1 = OrderLog();
  OrderLog log2 = OrderLog();

  for (int i = 1; i <= u + 2; i++) {
    String message = 'order #${100 * t + i}';

    if (i % 2 == 1) {
      log1.add(message);
    } else {
      log2.add(message);
    }
  }

  print('Step 4: same object? ${identical(log1, log2)}');
  print('Step 4: entries = ${log1.entries.length}');
  print('Step 4: last = ${log2.entries.last}');
}

void step5() {
  OrderLine line = mainOrder();

  print('Step 5: ${line.item.name} x${line.qty}');
  print('Step 5: total=${line.total} tax=${line.tax}');

  try {
    OrderLine(line.item, 0);
    print('Step 5: assert did NOT fire');
  } on AssertionError {
    print('Step 5: assert fired');
  }

  
}

void step6() {
  OrderLine line = mainOrder();

  print('Step 6: grand=${line.grand}');
  print('Step 6: big order? ${line.isBigOrder} (limit $bigOrderLimit)');
  print('Step 6: label=${line.label}');

  // [line.grand = 5;} would fail because grand is a getter with no setter To make it free for error  we would need to add a setter for grand..
}

void step7() {
  StudentCard card = StudentCard('S$seed');

  card.balance = seed * 10 + 50;
  print('Step 7: topped up -> ${card.balance}');

  card.balance = -seed - 1;
  print('Step 7: bad value -> ${card.balance}');

  card.balance = balanceCap - u;
  print('Step 7: reset -> ${card.balance}');

  card.balance = card.balance - mainOrder().grand;
  print('Step 7: paid order -> ${card.balance}');
}

void step8() {
  List<MenuItem> items = buildMenu();

  MenuItem priciest = items.reduce(
    (a, b) => a.price > b.price ? a : b,
  );

  int sum = items.fold(
    0,
    (total, item) => total + item.price,
  );

  print('Step 8: menu = $items');
  print('Step 8: priciest = ${priciest.name}');
  print('Step 8: sum = $sum');
}


void step9() {
  List<OrderLine> receipt = buildReceipt();

  int receiptTotal = 0;

  for (OrderLine line in receipt) {
    print('Step 9: ${line.label} = ${line.grand}');

    OrderLog().add('receipt: ${line.label}');

    receiptTotal += line.grand;
  }

  print('Step 9: receipt total = $receiptTotal');
  print('Step 9: log size = ${OrderLog().entries.length}');
}


void step10() {
  String code = 'CAFE${seed.toString().padLeft(2, '0')}';

  Coupon c1 = Coupon.fromCode(code);
  Coupon c2 = Coupon.fromCode(code);

  int receipt = 0;

  for (OrderLine line in buildReceipt()) {
    receipt += line.grand;
  }

  int discount = c1.discountOn(receipt);
  int payable = receipt - discount;

  print(
    'Step 10: $code gives ${c1.percent}% off, min spend ${c1.minSpend}',
  );

  print('Step 10: cached? ${identical(c1, c2)}');

  print(
    'Step 10: receipt $receipt, discount $discount, payable $payable',
  );
}