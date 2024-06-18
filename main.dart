import 'dart:io';
import 'dart:convert';

abstract class Describable {
    void describe();
}

class Animal implements Describable {
    String name;
    int age;

    Animal(this.name, this.age);

    @override
    void describe() {
        print('This is a $name, aged $age years.');
    }

    void makeSound() {
        print('$name makes a sound.');
    }
}

class Dog extends Animal {
    String breed;

    Dog(String name, int age, this.breed): super(name, age);

    @override
    void makeSound() {
        print('$name barks.');
    }

    void showTricks(List<String> tricks) {
        print('$name knows the following tricks:');
        for (var trick in tricks) {
            print('- $trick');
        }
    }
}

Future<Dog> initializeDogFromFile(String filepath) async {
    final file = File(filepath);
    final contents = await file.readAsString();
    final data = jsonDecode(contents);

    final name = data['name'];
    final age = data['age'];
    final breed = data['breed'];

    return Dog(name, age, breed);
}

void main() async {
    const filepath = 'dog_data.json';

    final dog = await initializeDogFromFile(filepath);

    dog.describe();

    dog.showTricks(['Sit', 'Stay', 'Roll over']);
}