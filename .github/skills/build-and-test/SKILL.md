---
name: build-and-test
description: "Налаштування Maven і JUnit 5 для Java-проєкту, створення тесту, запуск build/test та формування виконуваного JAR-файлу."
argument-hint: "Шлях до Java-проєкту або Maven artifactId"
---

# Build and Test

## Призначення

Skill налаштовує Maven для Java-проєкту, додає JUnit 5, створює тестову
функцію та відповідний unit-тест, запускає складання й перевірки та формує
виконуваний JAR-файл.

## Вхідні параметри

- `projectRoot` — корінь Git-репозиторію та Java-проєкту з `src/main/java`.
- `artifactId` — Maven-ідентифікатор, для цього завдання `HelloProject`.
- `javaVersion` — версія JDK, сумісна з локальним середовищем і CI.
- `junitVersion` — версія JUnit 5, яку треба зафіксувати в `pom.xml`.

## Послідовність виконання

1. Перевір наявність Java і Maven та визнач активні версії.
2. Прочитай наявний `pom.xml`, якщо він існує; не дублюй залежності або
   plugins.
3. Створи або онови `pom.xml` з `groupId`, `artifactId`, `version`,
   `maven.compiler.release`, JUnit Jupiter dependency зі scope `test` і
   `maven-surefire-plugin`, сумісним з JUnit 5.
4. Створи тестову функцію в основному коді, наприклад
   `HelloProject.greeting()`, яка повертає `Hello, World!`.
5. Створи відповідний JUnit 5 unit-тест із `@Test` і перевіркою `assertEquals`.
6. Запусти `mvn test`, перевір результат і кількість тестів.
7. Запусти `mvn package` з успішним проходженням тестів.
8. Налаштуй manifest із `Main-Class` і переконайся, що `mvn package` формує
   виконуваний `build/hello.jar`. Перевір його командою
   `java -jar build/hello.jar`.

## Приклад вхідних даних

```text
projectRoot=.
artifactId=HelloProject
javaVersion=17
junitVersion=5.11.0
```

## Очікуваний результат

- У корені є коректний `pom.xml`.
- JUnit 5 підключено через Maven dependency.
- Є тестова функція та JUnit 5 unit-тест.
- `mvn test` і `mvn package` завершуються з кодом 0.
- У `build/` створено `hello.jar`, який запускається через
  `java -jar`.

## Перевірки правильності виконання

- Перевір XML-структуру `pom.xml` і відсутність дубльованих dependency/plugin.
- Перевір фактичне завантаження JUnit 5 і запуск тесту Maven Surefire.
- Перевір, що помилки компіляції або тестів не замасковані.
- Перевір наявність `build/hello.jar` та коректне значення `Main-Class` у manifest.
- Збережи короткий результат `mvn test`, `mvn package` і запуску JAR.

## Типова помилка та обробка

Якщо Maven або JDK відсутні, зупинись і повідом назву відсутнього інструмента
та команду для перевірки `java -version` або `mvn -version`. Якщо Maven не
може завантажити JUnit 5, повідом про недоступний репозиторій або залежність і
не оголошуй збірку успішною. Якщо тест або компіляція падає, наведи фактичну
помилку, виправ лише пов'язану конфігурацію чи код і повтори перевірки.
