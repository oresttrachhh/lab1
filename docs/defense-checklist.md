# Підготовка до захисту Build Engineer Agent

## 1. Демонстрація агента
- Показати manifest build-engineer.agent.md.
- Показати три Skills.
- Показати шість prompt-команд.

## 2. Демонстрація роботи
- Запустити init через інструкції init.prompt.md.
- Запустити check.
- Показати повторний безпечний запуск init.

## 3. Перевірка помилок
- Продемонструвати навмисно зламану перевірку.
- Показати повідомлення про помилку.
- Виправити проблему та повторно запустити check.

## 4. Локальне тестування
- mvn clean test
- mvn package
- java -jar build/hello.jar

## 5. GitHub Actions
- Показати успішні перевірки Windows, Ubuntu та macOS.
- Показати запуск workflow через push і pull_request.

## 6. Документація
- docs/architecture.md
- docs/usage.md
- docs/ai-log.md

## 7. Відеозапис
Записати демонстрацію роботи агента та завантажити відео у папку, визначену викладачем.