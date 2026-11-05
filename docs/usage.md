# Користування HelloProject

## Передумови

- JDK 17 або новіший;
- Maven 3.9 або новіший;
- Git (для роботи з репозиторієм).

Java-проєктом є корінь цього Git-репозиторію. Maven-файл розташований у
`pom.xml`, а вихідний код і тести — у стандартних каталогах `src/main/java` та
`src/test/java`.

## Перевірка і складання

Запустіть із кореня репозиторію:

```text
mvn test
mvn package
```

Виконуваний JAR буде створено в `target/`. Запустити його можна так:

```text
java -jar target/HelloProject-1.0-SNAPSHOT.jar
```

Очікуваний вивід:

```text
Hello, World!
```

## Скрипти CI

- Windows: `ci.bat`
- Linux/macOS: `bash ./ci.sh`

Скрипти запускають тести, створюють JAR і перевіряють його запуск. GitHub Actions
використовує ці скрипти через workflow [.github/workflows/ci.yml](../.github/workflows/ci.yml).
