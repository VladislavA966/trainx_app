# Makefile

# Генерация кода (например, freezed, json_serializable и т.п.)
gen:
	flutter pub run build_runner build --delete-conflicting-outputs

# Получение зависимостей
get:
	flutter pub get

# Очистка проекта
clean:
	flutter clean
