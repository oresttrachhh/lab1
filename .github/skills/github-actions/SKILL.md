---
name: github-actions
description: "Створення GitHub Actions CI для Java/Maven/JUnit 5 з матрицею Windows, Linux і macOS та запуском складання через ci.bat або ci.sh."
argument-hint: "Назва workflow та версія Java"
---

# GitHub Actions

## Призначення

Skill створює кросплатформний `.github/workflows/ci.yml` для Java-проєкту
HelloProject. Workflow налаштовує середовище та делегує всі операції
складання, тестування і генерації JAR-файлу окремим скриптам `ci.bat` для
Windows і `ci.sh` для Linux/macOS.

## Вхідні параметри

- `workflowName` — назва workflow, наприклад `HelloProject CI`.
- `javaVersion` — версія JDK для `actions/setup-java`.
- `projectRoot` — корінь Maven-проєкту.
- `scriptPaths` — шляхи до `ci.bat` і `ci.sh`; за замовчуванням вони лежать у
  корені репозиторію.

## Послідовність виконання

1. Перевір структуру проєкту, `pom.xml` і наявність Maven.
2. Створи `ci.bat` з `@echo off`, переходом до кореня репозиторію та командами
   Maven для clean, test, package і перевірки JAR; заверши скрипт ненульовим
   кодом при помилці.
3. Створи `ci.sh` з `set -euo pipefail`, переходом до кореня репозиторію та
   такими самими операціями Maven; зроби його виконуваним для Unix-середовищ.
4. Створи `.github/workflows/ci.yml` з подіями `push` і `pull_request`,
   permissions мінімально необхідного рівня та матрицею:
   `windows-latest`, `ubuntu-latest`, `macos-latest`.
5. Додай `actions/checkout` і `actions/setup-java` у кожен job та кеш Maven.
6. У `ci.yml` для Windows запускай лише `.\ci.bat`, а для Linux/macOS — лише
   `bash ./ci.sh`.
7. Перевір YAML, shell/batch-синтаксис і відповідність job-логів зрозумілим
   назвам кроків.

**Обов'язкова умова:** `ci.yml` не повинен містити `mvn`, `mvnw`, `mvn.cmd`
або безпосередні команди складання чи тестування. Усі Maven-операції мають
бути тільки в `ci.bat` і `ci.sh`.

## Приклад вхідних даних

```text
workflowName=HelloProject CI
javaVersion=17
projectRoot=.
scriptPaths={windows: ci.bat, unix: ci.sh}
```

## Очікуваний результат

- `.github/workflows/ci.yml` містить матрицю Windows, Linux і macOS.
- Workflow використовує `actions/checkout` та `actions/setup-java`.
- Windows job запускає `ci.bat`, а Linux/macOS job запускає `ci.sh`.
- Усі Maven build, JUnit 5 test і генерація JAR виконуються скриптами.
- Кроки мають зрозумілі назви, а помилка скрипта робить job невдалим.

## Перевірки правильності виконання

- Перевір, що workflow YAML синтаксично коректний і містить три ОС.
- Перевір наявність обох скриптів і коректні права/рядки завершення.
- Перевір, що `ci.yml` не містить Maven-команд, а містить тільки виклики
  `ci.bat` або `ci.sh` після налаштування середовища.
- Перевір, що скрипти завершуються з помилкою при невдалому `mvn`.
- Локально запусти відповідний скрипт на доступній ОС або перевір його
  синтаксис без підміни результату CI.

## Типова помилка та обробка

Якщо workflow містить `mvn` напряму, видали цю команду з `ci.yml` і перенеси
операцію до відповідного скрипта. Якщо `ci.sh` не має права виконання,
виправ режим файлу або запускай його через `bash`. Якщо matrix job не знаходить
скрипт, перевір `working-directory` і шляхи. Не приховуй ненульовий код скрипта
через `continue-on-error`; job має завершуватися невдало з поясненням у логах.
