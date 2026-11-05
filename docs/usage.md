# Користування HelloProject

## Передумови

- JDK 17 або новіший;
- Maven 3.9 або новіший;
- Git (для роботи з репозиторієм).

Java-проєктом є корінь цього Git-репозиторію. Maven-файл розташований у
`pom.xml`, а вихідний код і тести — у стандартних каталогах `src/main/java` та
`src/test/java`.

## Точні команди

У VS Code відкрийте Chat, виберіть **Build Engineer Agent** і надішліть точну
команду:

```text
@Build Engineer Agent init
```

Для локального тестування з кореня репозиторію:

```text
mvn test
```

Для складання:

```text
mvn package
```

Виконуваний JAR буде створено в `build/`. Запустити його можна так:

```text
java -jar build/hello.jar
```

Очікуваний вивід:

```text
Hello, World!
```

## Скрипти CI

- Windows: `ci.bat`
- Linux/macOS: `bash ./ci.sh`

Скрипти запускають тести, створюють JAR і перевіряють його запуск. Вони також
повертають ненульовий код і показують повідомлення про помилку, якщо будь-який
етап не виконано. GitHub Actions використовує ці скрипти через workflow
[.github/workflows/ci.yml](../.github/workflows/ci.yml).

## GitHub Actions

Workflow запускається для подій `push` і `pull_request`, спрямованих у гілки
`main`, `develop` або `master`. Єдина job `build` виконується матрицею на
`ubuntu-latest`, `windows-latest` і `macos-latest`. На Windows запускається
`ci.bat`, а на Linux і macOS — `bash ./ci.sh`; workflow не виконує Maven-команди
безпосередньо.

Перелік запусків і результати доступні на сторінці
[GitHub Actions](https://github.com/oresttrachhh/lab1/actions). Відкрийте потрібний
запуск і перевірте, що job `build` має зелений статус на всіх трьох ОС. Для
деталей розгорніть крок скрипта: успішний запуск містить повідомлення
`SUCCESS`, а помилка будь-якого скрипта робить job невдалим.

Перевірити Git ignore можна так:

```text
git check-ignore -v build/hello.jar
git status --short --ignored build
```
