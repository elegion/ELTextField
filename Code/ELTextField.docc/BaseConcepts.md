# Базовая концепция

Глянем, что есть у библиотеки

## Основные компоненты библиотеки

Базовыми компонентами библиотеки служит класс ``ELDefaultTextFieldBehavior``, который **служит для описания** работы поля ввода, и ``ELTextFieldGenericContainer``, который представляет **UI представление поля ввода**

### Как описать внешний вид поля ввода

Само поле ввода оборачивается в класс ``ELTextFieldGenericContainer``. На уровне библиотеки не нужно оперировать понятиями *UITextField* и *UITextView*. Они инкапсулированы внутри Контейнера. Равно как и не надо думать о *UITextFieldDelegate* и *UITextViewDelegate*.

``ELTextFieldGenericContainer`` реализован на дженериках, и принимает 2 сущности:
* Configuration. Реализует протокол ``ELTextFieldConfigurationProtocol``;
* Behavior. Реализует протокол ``ELTextFieldBehavior``.

