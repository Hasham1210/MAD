// library_lab.dart  -  Campus Library System
// Name: Raja Hasham Ahmed   Roll no: 04072313006

const String rollNo = '04072313006'; // e.g. '21F-0347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> titles = [
  'Dart Basics',
  'Flutter In Action',
  'Data Structures',
  'Operating Systems',
  'Mobile Design',
  'Clean Code',
  'Algorithms Unlocked',
  'Computer Networks',
  'Database Systems',
  'Software Testing',
];

int yearOf(int i) => 1995 + 2 * i + t; // publication year of titles[i]
final int feePerDay = 5 + t; // late fee per day, in rupees
final int daysLate = 3 + (t + u) % 6; // normal number of days late
final int daysBig = 10 + u; // a long overdue period
final int feeCap = 150 + 10 * t; // no single fee may exceed this
final int renewLimit = 1 + t % 3; // renewals allowed per item
final int renewAttempts = 2 + u; // renewal attempts made in Step 5
final int shelfSize = 3 + u % 4; // items on the shelf in Steps 9-10
// ===========================================================================

// 1.1 and 3.1
abstract class LibraryItem {
  final String title;
  final int year;

  LibraryItem(this.title, this.year);

  String describe() => '$title ($year)';

  int lateFee(int days);
}

// Step 4.1
abstract class Borrowable {
  bool get isAvailable;

  void borrow();

  void giveBack();
}

// 1.2 2.2 3.2

// Steps 4.2
//5.2
class Book extends LibraryItem with Renewable implements Borrowable {
  final int pages;

  bool _out = false;

  Book(super.title, super.year, this.pages);

  @override
  String describe() => '${super.describe()}, $pages pages';

  @override
  int lateFee(int days) {
    return days * feePerDay;
  }

  // Step 4.2
  @override
  bool get isAvailable => !_out;

  @override
  void borrow() {
    _out = true;
  }

  @override
  void giveBack() {
    _out = false;
  }
}

// 1.3 2.3 3.3
class Magazine extends LibraryItem {
  final int issue;

  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue $issue';

  @override
  int lateFee(int days) {
    return days * (feePerDay ~/ 2);
  }
}

// 3.22
//5.2
class Dvd extends LibraryItem with Renewable {
  final int minutes;

  Dvd(super.title, super.year, this.minutes);

  @override
  String describe() => '${super.describe()}, $minutes min';

  @override
  int lateFee(int days) {
    return days * feePerDay * 2;
  }
}

//2.4:
Magazine mainMagazine() {
  int i = (u + 1) % 10;
  return Magazine(titles[i], yearOf(i), 1 + (t + u) % 12);
}

// Step 3: Create the main DVD
Dvd mainDvd() {
  int i = (u + 2) % 10;
  return Dvd(titles[i], yearOf(i), 120);
}

//1.3
Book mainBook() {
  return Book(titles[u], yearOf(u), 100 + 3 * seed);
}




//5.1::
mixin Renewable {
  int renewals = 0;

  bool renew(int limit) {
    if (renewals >= limit) {
      return false;
    }
    renewals++;
    return true;
  }
}
//task 6::
enum MemberType {
  student(3, 50),
  faculty(10, 20),
  guest(1, 0);

  final int maxLoans;
  final int discountPercent;

  const MemberType(this.maxLoans, this.discountPercent);
  // TODO: int applyDiscount(int fee) -> fee minus discountPercent % of fee
 //:


  int applyDiscount(int fee) {
    return fee - (fee * discountPercent ~/ 100);
  }
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
  print('--- Step 1 ---');

  Book b = mainBook();

  LibraryItem item = b;

  print('Step 1: ${b.title} (${b.year}), ${b.pages} pages');
  print('Step 1: stored as LibraryItem: ${item.title}');
  print('Step 1: runtimeType = ${item.runtimeType}');

  // {{item.pages} is a compile time error because pages is not already defined in LibraryItem class.
}

void step2() {
  print('--- Step 2 ---');

  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');

  // If the function: describe() would be as descibe() ..Then  it may create a different another method instead of overriding
}

void step3() {
  print('--- Step 3 ---');

  Book book = mainBook();
  Magazine magazine = mainMagazine();
  Dvd dvd = mainDvd();

  print('Step 3: Book fee = Rs ${book.lateFee(daysLate)}');
  print('Step 3: Magazine fee = Rs ${magazine.lateFee(daysLate)}');
  print('Step 3: DVD fee = Rs ${dvd.lateFee(daysLate)}');


   // LibraryItem is abstract class so we cannot create its object at this tieme..
  // It is designed to give us a structure for subclasses We must create an object
  // of a concrete subclass same like.. Book - Magazine - Dvd
}


void step4() {
  print('--- Step 4 ---');

  Book book = mainBook();

  print('Step 4: available? ${book.isAvailable}');

  book.borrow();
  print('Step 4: after borrow? ${book.isAvailable}');

  book.giveBack();
  print('Step 4: after return? ${book.isAvailable}');

  List<LibraryItem> items = [
    book,
    mainMagazine(),
    mainDvd(),
  ];

  for (LibraryItem item in items) {
    print(
      'Step 4: ${item.runtimeType} borrowable? ${item is Borrowable}',
    );
  }

// If Book extended the class as Borrowable then it may inherit implementation from Borrowable
// if it wwas a concrete class with built methods
}

void step5() {
  print('--- Step 5 ---');
  Book book = mainBook();

  int ok = 0;

  for (int i = 0; i < renewAttempts; i++) {
    if (book.renew(renewLimit)) {
      ok++;
    }
  }

  print(
    'Step 5: renewed $ok of $renewAttempts attempts '
    '(limit $renewLimit)',
  );

  print('Step 5: renew once more? ${book.renew(renewLimit)}');

  print('Step 5: dvd can renew too? ${mainDvd().renew(1)}');

//  mixin here.. allows the  Book and Dvd to share renewal ability
//without giving Magazine a renew() methiod it does not need This avoids adding 
//unrelated functionality to eeach of trhe library item.
}

void step6() {
  print('--- Step 6 ---');

  MemberType member = MemberType.student;
  int fee = mainBook().lateFee(daysLate);

  print(
    'Step 6: member type = ${member.name} '
    '(index ${member.index})',
  );
  print('Step 6: max loans = ${member.maxLoans}');
  print(
    'Step 6: book fee $fee -> '
    '${member.applyDiscount(fee)} after discount',
  );



   // MemberType.student is more safe than the string ->student because enum can be
   // values to predefined member types
}
void step7() {
  print('--- Step 7 ---');
}

void step8() {
  print('--- Step 8 ---');
}

void step9() {
  print('--- Step 9 ---');
}

void step10() {
  print('--- Step 10 ---');
}
