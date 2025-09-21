## Debang

En | [Ru](README_RU.md)

Debang is a library for Dart/Flutter that helps document and handle cases of
unexpected null values. Instead of simply using the `!` operator, it requires
the developer to provide an explanation (assertion) as to why the value is
guaranteed not to be `null`. This makes errors more informative, simplifies
debugging, and improves code quality within the team.

### Motivation

In Dart/Flutter development, situations often arise where a developer is
confident that a value cannot be `null` and uses the `!` operator for forced
unwrapping. However, over time, the context may change, leading to errors in
production. The `Debang` library solves this problem by forcing the developer to
immediately document their assumptions in the form of an `assertion` — an
explanation of why the value is guaranteed not to be `null`. This not only
improves debugging but also enhances code quality.

Examples:

1. A developer writes code and uses `!` because they are confident in the logic
   at the moment (e.g., "the value is initialized above"). A month later, a
   `NullPointerException`-like error occurs in production. When asked, the
   author replies: _"I don't remember"_. With `Debang`, instead of a simple `!`,
   you use
   `.debang('This value is guaranteed not to be null because it is initialized in the class constructor')`,
   which in turn:

   - Forces the developer to think and justify their confidence at the time of
     writing the code.
   - If the justification seems weak, they can immediately change the logic to
     avoid potential problems.
   - In case of an error, the `assertion` becomes an "explanatory note" that
     helps quickly understand the context without digging deep into commit
     history.

2. A new developer changes the context: A new team member joins the project and,
   unaware of all the nuances, deletes or modifies the logic that ensured the
   value's initialization (e.g., removes a method call that filled the
   variable). As a result, the code crashes on null. Without Debang, the error
   would be generic: "Null check operator used on a null value" — and you'd have
   to manually figure out what broke. With Debang, when the exception is thrown,
   the log or crash report shows the assertion: for example, "The value is not
   null because it is always set in the init() method". This immediately
   suggests:

   - Which logic was violated (reference to init() in the assertion).
   - Go to the code line with .debang() and do git blame — you'll see the
     original author who added this assumption and the change history.
   - You can discuss with those involved (the assertion author and the one who
     deleted) why the logic changed and quickly fix it.
   - This makes the code resilient to refactoring: the assertion serves as
     "documentation in the error", helping the team quickly localize the problem
     and find those responsible.

## Installation

Add to `pubspec.yaml`:

```yaml
dependencies:
  debang: ^1.0.0
```

Then run:

```bash
dart pub get
```

Or using the command:

```bash
dart pub add debang
```

After installation, import the library:

```dart
import 'package:debang/debang.dart';
```

## Usage

```dart
String? maybeNull;
/* 
logic for initializing `maybeNull`
which, in the developer's opinion, shouldn't break
but it did
*/
final nonNull = maybeNull.debang('Definitely not null, since I initialized and handled all null errors above');
```

If `maybeNull` turns out to be `null`, a `Debang` with `assertion` will be
thrown.

```bash
This exception occurred because a `Debang` assertion failed
Assertion: Definitely not null, since I initialized and handled all null errors above
Expected:  String
Method:    SomeClass.someMethod
File:      some_file.dart:2:27
```

## Settings

The library has global options in Debang.options, which can be changed for
customization. By default, they are set for convenient output without
unnecessary verbosity.

#### Available options

```dart
// Default values shown
// Can also be changed using `copyWith()`
Debang.options = Debang.options.copyWith(
    showExpected: true,   		// Show expected type in error message
    showMethod: true,   		// Show method name
	showFile: true,				// Show file, line
	shouldNotifyObservers: true	// Notify observers when exception is created
    showStackTrace: false,  	// Show full stacktrace
  );
```

## Observers

```dart
class SomeLogger implements DebangObserver {
  @override
  void call(Debang debang) {
    print('Error: ${debang.assertion}, type: ${debang.expectedType}, file: ${debang.frame?.file}');
    // Or send to Sentry/Crashlytics
  }
}

// Registration
// When `throw Debang()` observer will be called
Debang.observers.add(SomeLogger());

// Removal
Debang.observers.remove(SomeLogger());
```

## Changelog

The list of changes is available in the file
[CHANGELOG.md](https://github.com/pavluke/debang/blob/main/CHANGELOG.md)

## Contributions

Feel free to contribute to this project. If you find a bug or want to add a new
feature but don't know how to fix/implement it, please write in
[issues](https://github.com/pavluke/debang/issues). If you fixed a bug or
implemented some feature, please make
[pull request](https://github.com/pavluke/debang/pulls).

## Лицензия

MIT License. Details in LICENSE.
