# ``ELTextField``

Библиотека для работы с полями ввода

## Обзор

При работе с полями ввода зачастую необходимо потратить довольно много времени для реализации того или иного поведения. В случае, если в приложении много полей ввода, удобная поддержка требует больших усилий и при неправильном подходе может привести к наличию избыточного и дублирующего кода в проекте. 

ELTextField позволяет абстрагироваться от деталей реализации UTextField и UITextView, быстро реализуя поля ввода с необходимой логикой валидации полей и маски ввода.

## Topics

### Начало

- <doc:/tutorials/ELTextField>
- <doc:Motivation>
- <doc:BaseConcepts>

### Поведение

- ``ELTextFieldBehavior``
- ``ELDefaultTextFieldBehavior``

### Containers

- ``ELTextFieldGenericContainer``

### Configurations

- ``ELTextFieldConfigurationProtocol``
- ``ELTextInputConfigurable``
- ``ELTextInputLayerConfiguration``

### Маски ввода

- ``ELTextFieldInputMask``
- ``ELDefaultTextMask``
- ``ELDigitTextMask``

### Валидация

- ``ELDefaultTextFieldValidator``
