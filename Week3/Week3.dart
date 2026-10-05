// Week3.dart - Library Desk Assistant
// Name: ____________________ Roll no: ____________
final List<Map<String, dynamic>> books = [
 {'title': 'Dart in Action', 'author': 'Ada', 'year': 2021,
 'copies': 3, 'tags': ['dart', 'programming']},
 {'title': 'Flutter Basics', 'author': 'Sam', 'year': 2023,
 'copies': 0, 'tags': ['flutter', 'mobile']},
 {'title': 'Clean Code', 'author': 'Martin', 'year': 2008,
 'copies': 2, 'tags': ['programming', 'design']},
 {'title': 'Algorithms', 'author': 'Knuth', 'year': 1968,
 'copies': 1, 'tags': ['programming', 'math']},
 {'title': 'UI Design', 'author': 'Nora', 'year': 2019,
 'copies': 4, 'tags': ['design', 'mobile']},
];

// Task 1.1: Positional parameters
//Args Must be passed in the declared order while caling them!
double lateFee(int daysLate, double ratePerDay) =>
    daysLate * ratePerDay;

// Task 1.2: Optional positional parameter
String formatTitle(String title, [String? author]) {//Autor=>>Positional parameter..
  if (author == null) {
    return title;
  }

  return '$title by $author';
}


// Task 1.3: Named parameters with required and a default
Map<String, dynamic> makeBook({ required String title,required String author,int year = 2024, int copies = 1,}) {
  return {
    'title': title,
    'author': author,
    'year': year,
    'copies': copies,
  };
}

// Task 1.4: Arrow function
bool isClassic(int year) => year < 2000;




//TASK###-- 02::

//Task 2.1: Passing a function as an argument
List<String> transformAll(List<String> items, String Function(String) fn) {
  return items.map(fn).toList();
}
// Task 2.2: A closure that remembers
int Function() makeCounter() {
  int count = 0;

  return () {
    count++;
    return count;
  };
}

//Task 2.3: A closure with a parameter


double Function(int) makeFeeCalculator(double rate) {
  return (days) => days * rate;
}

// Task 2.4: Recursion

int sumDigits(int n) {
  if (n < 10) {
    return n;
  }

  return (n % 10) + sumDigits(n ~/ 10);
}


//Part 3: 3.4cls

Map<String, int> buildStock() {
  return {
    for (var b in books)
      b['title'] as String: b['copies'] as int
  };
}




//part : 4::
class Box<T> {
  T value;

  Box(this.value);
}



T firstOr<T>(List<T> items, T fallback) {
  if (items.isNotEmpty) {
    return items.first;
  }

  return fallback;
}

class Pair<A, B> {
  A first;
  B second;

  Pair(this.first, this.second);

  @override
  String toString() {
    return '($first, $second)';
  }
}


 //-->:: Part 5 

class BookNotFoundException implements Exception {
  final String title;

  BookNotFoundException(this.title);
}

class BookNotAvailableException implements Exception {
  final String title;

  BookNotAvailableException(this.title);
}

void checkOut(Map<String, int> stock, String title) {
  if (!stock.containsKey(title)) {
    throw BookNotFoundException(title);
  }

  if (stock[title]! <= 0) {
    throw BookNotAvailableException(title);
  }

  stock[title] = stock[title]! - 1;
}

Map<String, dynamic> findBook(String title) {
  return books.firstWhere(
    (book) => book['title'] == title,
  );
}


//::PART ## 06
Future<String> fetchBookOfTheDay() async {
  await Future.delayed(Duration(seconds: 1));

  return 'Dart in Action';
}

Future<String> fetchBroken() async {
  await Future.delayed(Duration(milliseconds: 500));

  throw Exception('Server down');
}
void main() async {
 part1();
 part2();
 part3();
 part4();
 part5();
 await part6();
}
void part1() {
  print('--- Part 1 ---');

  print('Late fee: ${lateFee(5, 0.5)}');

  print(formatTitle('Dart in Action'));

  print(formatTitle('Dart in Action', 'Ada'));

  print(makeBook(title: 'Clean Code',  author: 'Martin',copies: 1,));

  print(makeBook(title: 'Algorithms',author: 'Knuth',year: 1968, ));

  print(isClassic(1968));

  print(isClassic(2021));
}

void part2() {
  print('--- Part 2 ---');

  var books = ['Dart in Action', 'Clean Code'];

  print(transformAll( books, (text) => text.toUpperCase(), ));

  print(transformAll( books, (text) => '$text!', ));

  var desk1 = makeCounter();
 var desk2 = makeCounter();

print(desk1());
print(desk1());
print(desk1());

print(desk2());


var studentFee = makeFeeCalculator(0.25);
var staffFee = makeFeeCalculator(0.10);

print('Student fee: ${studentFee(4)}');
print('Staff fee: ${staffFee(4)}');
 print('Sum of digits: ${sumDigits(8)}');
}

void part3() {
  print('--- Part 3 ---');

  // Task 3.1->
  var titles = books.map((b) => b['title'] as String).toList();

  var available = books
      .where((b) => (b['copies'] as int) > 0)
      .map((b) => b['title'] as String)
      .toList();

  print('Titles: $titles');
  print('Available: $available');

  // Task 3.2--
  var totalCopies = books.fold<int>(
    0,
    (sum, b) => sum + (b['copies'] as int),
  );

  var years = books.map((b) => b['year'] as int).toList();

  var oldestYear = years.reduce((a, b) => a < b ? a : b);

  print('Total copies: $totalCopies');
  print('Oldest year: $oldestYear');



// Task 3.3
  var sortedBooks = [...books];

  sortedBooks.sort(
    (a, b) => (a['year'] as int).compareTo(b['year'] as int),
  );

  var sortedTitles =
      sortedBooks.map((b) => b['title'] as String).toList();

  print('By year: $sortedTitles');

//Task 3.4:::
var stock = buildStock();

print('Stock: $stock');

stock.forEach((title, copies) {
  if (copies == 0) {
    print('Out of stock: $title');
  }
});

print('Copies of Unknown: ${stock['Unknown'] ?? 0}');


//tasK :3.5:
var allTags = {
  for (var b in books) ...(b['tags'] as List<String>)
};

print('All tags: $allTags');

var a = {'Dart in Action', 'Clean Code', 'Flutter Basics'};
var b = {'Clean Code', 'Flutter Basics', 'Algorithms'};

print('Union: ${a.union(b)}');
print('Common: ${a.intersection(b)}');
print('Only in A: ${a.difference(b)}');
}


void part4() {
  print('--- Part 4 ---');

  var intBox = Box<int>(5);
  var stringBox = Box<String>('dart');

  print('Box<int>: ${intBox.value}');
  print('Box<String>: ${stringBox.value}');

  // intBox.value = 'hello';

  print(firstOr(['Dart in Action', 'Clean Code'], 'none'));

  print(firstOr<String>([], 'z'));

  print(Pair('Dart in Action', 3));
}


void part5() {
  print('--- Part 5 ---');

  var stock = buildStock();

  for (var title in [
    'Dart in Action',
    'Flutter Basics',
    'Unknown Book'
  ]) {
    try {
      checkOut(stock, title);

      print('Checked out: $title');
    } on BookNotAvailableException {
      print('Sorry: "$title" has no copies left');
    } on BookNotFoundException {
      print('Not found: "$title"');
    } finally {
      print('Transaction logged.');
    }
  }

  print('Copies left of Dart in Action: ${stock['Dart in Action']}');

  try {
    findBook('Missing');
  } on StateError {
    print('Search failed: no such book');
  }
}
Future<void> part6() async {
  print('--- Part 6 ---');

  print('Fetching...');

  var book = await fetchBookOfTheDay();

  print('Book of the day: $book');

  try {
    await fetchBroken();
  } catch (e) {
    print('Fetch failed: $e');
  }
}



